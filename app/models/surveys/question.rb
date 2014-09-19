class Question < ActiveRecord::Base
  has_and_belongs_to_many :answer_templates
  belongs_to :group
  has_many :answers
  has_many :votes
  belongs_to :question_help_message

  include Localizable
  localize :text

  include Authority::Abilities
  self.authorizer_name = "AdminAuthorizer"

  # DAG
  has_dag_links :link_class_name => 'QuestionEdge'

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
    candidate_edges.select {|edge| edge.condition.blank? }.first.descendant
  end

  def default_previous_question(question_flow)
    candidate_edges = QuestionEdge.where(child_question_id: self[:id], question_flow_id: question_flow.id, direct: true)
    candidate_edges.select {|edge| edge.condition.blank? }.first.ancestor
  end

  def conditional_children(question_flow)
    candidate_edges = QuestionEdge.where(parent_question_id: self[:id], question_flow_id: question_flow.id, direct: true)
    candidate_edges.select {|edge| edge.condition.present? }.map(&:descendant)

  end

  def user_answer(answer_session)
    answers.where(answer_session_id: answer_session.id).first
  end

  def rating
    votes.sum(:rating)
  end

  def has_vote?(user, rating)
    votes.where(user_id: user.id, rating: rating).count > 0
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
    if answer_templates.length == 1 and [3,4].include? answer_templates.first.display_type.id
      at = answer_templates.first
      all_options = at.answer_options.to_a.sort_by!{|ao| ao.value }

      groups = []

      all_options.each do |o|
        groups << {label: o.value, answers: [], count: 0, frequency: 0.0}
      end

      total_answers = answers.map(&:answer_values).flatten.map(&:show_value).length

      answers.map(&:answer_values).flatten.group_by{|av| av.show_value}.each_pair do |key, array|
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
