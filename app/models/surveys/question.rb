class Question < ActiveRecord::Base
  has_and_belongs_to_many :answer_templates
  belongs_to :group
  has_many :answers
  belongs_to :question_help_message

  include Localizable
  include Votable

  has_many :votes

  include Authority::Abilities

  localize :text
  has_dag_links :link_class_name => 'QuestionEdge'

  self.authorizer_name = "AdminAuthorizer"

  # DAG

  def next_question(question_flow)
    candidate_edges = QuestionEdge.where(parent_question_id: self[:id], question_flow_id: question_flow.id, direct: true)
    candidate_edges.first
  end

  def previous_question(question_flow)
    candidate_edges = QuestionEdge.where(child_question_id: self[:id], question_flow_id: question_flow.id, direct: true)
    candidate_edges.first
  end

  def default_next_question(question_flow)
    candidate_edges = QuestionEdge.where(parent_question_id: self[:id], question_flow_id: question_flow.id, direct: true)
    candidate_edges.present? ? candidate_edges.select {|edge| edge.condition.blank? }.first.descendant : nil
  end

  def default_previous_question(question_flow)
    candidate_edges = QuestionEdge.where(child_question_id: self[:id], question_flow_id: question_flow.id, direct: true)
    candidate_edges.present? ? candidate_edges.select {|edge| edge.condition.blank? }.first.ancestor : nil
  end

  def conditional_children(question_flow)
    candidate_edges = QuestionEdge.where(parent_question_id: self[:id], question_flow_id: question_flow.id, direct: true)
    candidate_edges.select {|edge| edge.condition.present? }.map(&:descendant)

  end

  def user_answer(answer_session)
    answers.where(answer_session_id: answer_session.id).first
  end


  def part_of_group?
    group.present?
  end

  def group_member?(q)
    group_members.include? q
  end

  def group_members
    if part_of_group?
      group.questions
    else
      nil
    end

  end

  def answer_templates=(attribute_list)
    attribute_list.each do |attrs|
      answer_templates.build(attrs)
    end
  end

  def answer_frequencies
    #raise StandardError, "#{self.text_en} #{answer_templates.first.display_type.name}"
    if answer_templates.length == 1 and ["multiple_choice", "check_box"].include? answer_templates.first.display_type.name
      at = answer_templates.first
      all_options = at.answer_options.to_a.sort_by!{|ao| ao.value }

      groups = []

      all_options.each do |o|
        groups << {label: o.value, answers: [], count: 0, frequency: 0.0}
      end

      valid_answers = answers.map(&:answer_values).flatten.select{|av| av.value.present?}
      total_answers = valid_answers.map(&:show_value).length

      valid_answers.group_by{|av| av.show_value}.each_pair do |key, array|
        g = groups.find{|x| x[:label] == key }
        if g
          g[:answers] = array
          g[:count] = array.count
          g[:frequency] = array.count/total_answers.to_f
        end
      end

      groups

    end

  end

  def graph_frequencies
    groups = answers.group_by{|answer| answer.value}
    groups.inject({}) {|h, (k,v)| h[k] = v.length; h}
  end
end
