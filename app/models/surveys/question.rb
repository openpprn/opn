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
    candidate_edges = QuestionEdge.where(parent_question_id: self[:id], question_flow_id: question_flow.id)
    candidate_edges.first
  end

  def previous_question(question_flow)
    candidate_edges = QuestionEdge.where(child_question_id: self[:id], question_flow_id: question_flow.id)
    candidate_edges.first
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
    if [3,4].include? question_type.id
      all_options = answer_options.to_a.sort_by!{|ao| ao.value(answer_type.data_type)}

      groups = []

      all_options.each do |o|
        groups << {label: o.value(answer_type.data_type), answers: [], count: 0, frequency: 0.0}
      end

      total_answers = answers.select{|answer| answer.show_value.present?}.length

      answers.group_by{|answer| answer.show_value}.each_pair do |key, array|
        g = groups.find{|x| x[:label] == key }
        if g
          g[:answers] = array
          g[:count] = array.count
          g[:frequency] = array.count/total_answers.to_f
        end
      end

      groups
    elsif question_type.id == 6
    end

  end

  def graph_frequencies
    groups = answers.group_by{|answer| answer.value}
    groups.inject({}) {|h, (k,v)| h[k] = v.length; h}
  end
end
