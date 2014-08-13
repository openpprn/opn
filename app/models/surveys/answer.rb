class Answer < ActiveRecord::Base
  has_many :answer_values, dependent: :destroy
  belongs_to :question
  belongs_to :answer_session
  has_one :in_edge, class_name: "AnswerEdge", foreign_key: "child_answer_id", dependent: :destroy
  has_one :out_edge, class_name: "AnswerEdge", foreign_key: "parent_answer_id", dependent: :destroy
  belongs_to :user # When necessary

  def self.first_answer(question, answer_session)
    Answer.where(question_id: question.id, answer_session_id: answer_session.id).first
  end

  ## Different options:
  # single value, raw value!
  # single value, answer option id (multiple_choice)
  # Multiple Values, answer option id (check_box)
  # (not supported now) multiple values,

  def value=(val)
    answer_values.clear

    if question.question_type.store_raw_value
      target_field = question.answer_type.data_type
    else
      target_field = 'answer_option_id'
    end

    if question.question_type.allow_multiple and val.kind_of?(Array)
      val.each {|v| answer_values.build(target_field => v) }
    else
      answer_values.build(target_field => val)
    end

    if self.persisted?
      self.save
    end
  end

  def value(raw = false)
    if question.present? and question.answer_type.present?
      if raw or question.question_type.store_raw_value
        target_field = question.answer_type.data_type
      else
        target_field = 'answer_option_id'
      end

      if question.question_type.allow_multiple and answer_values.length > 1
        answer_values.map{|av| av[target_field] }
      elsif answer_values.length == 1
        answer_values.first[target_field]
      else
        nil
      end
    else
      nil
    end
  end

  def string_value(raw = false)
    v = value(raw)

    if v.kind_of?(Array)
      v.map(&:to_s)
    else
      v.to_s
    end
  end

  def show_value
    v = self.value
    if v
      if question.question_type.store_raw_value

        v
      else
        if v.kind_of?(Array)
          AnswerOption.where(id: v).map{|ao| ao.value(question.answer_type.data_type)}.join(', ')
        else

          AnswerOption.find(v).value(question.answer_type.data_type)
        end
      end
    end
  end

  def next_answer
    out_edge.present? ? out_edge.child_answer : nil
  end

  def previous_answer
    in_edge.present? ? in_edge.parent_answer : nil
  end

  def descendants
    descendant_list = []

    head = self.next_answer
    while head
      descendant_list << head
      head = head.next_answer
    end

    descendant_list
  end

  def destroy_descendant_edges
    descendants.each do |d|
      d.in_edge.destroy if d.in_edge
      d.out_edge.destroy if d.out_edge
    end
  end

  def next_question
    candidate_edges = question.links_as_parent

    if candidate_edges.empty?
      nil
    else
      if candidate_edges.length == 1
        chosen_edge = candidate_edges.first
      else
        chosen_edge = candidate_edges.select {|e| e.condition == self.value.to_s}.first || candidate_edges.select {|e| self.value.kind_of?(Array) ? self.value.map(&:to_s).include?(e.condition) : false }.first || candidate_edges.select { |e| e.condition == nil }.first || candidate_edges.first
      end
      chosen_edge.descendant
    end

  end

  def multiple_options?
    question.links_as_parent.length > 1
  end
end
