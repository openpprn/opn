class Answer < ActiveRecord::Base
  has_many :answer_values, dependent: :destroy
  belongs_to :question
  belongs_to :answer_option
  belongs_to :answer_session
  has_one :in_edge, class_name: "AnswerEdge", foreign_key: "child_answer_id", dependent: :destroy
  has_one :out_edge, class_name: "AnswerEdge", foreign_key: "parent_answer_id", dependent: :destroy
  belongs_to :user # When necessary

  def self.first_answer(question, answer_session)
    Answer.where(question_id: question.id, answer_session_id: answer_session.id).first
  end

  ## Different options:
  # It gets complicated with many answer templates
  #   at most basic, one answer template with not allowed multiple ==> target field gets value
  #   then, one answer templates with allowed multiple ==> builds from array of values
  #
  #   we repeat this for all answer templates
  #
  #   the inputs can be single value, array of values, hash with answer templates as keys
  #   if multiple answer templates are present, then hash is NECESSARY

  # single value, raw value!
  # single value, answer option id (multiple_choice)
  # Multiple Values, answer option id (check_box)
  # (not supported now) multiple values,

  def value=(val)
    answer_values.clear
    question.answer_templates.each do |template|
      target_field = template.data_type
      if val.kind_of?(Hash)
        val_for_template = val[template.id.to_s]
      else
        val_for_template = val
      end

      if template.allow_multiple and val_for_template.kind_of?(Array)
        val_for_template.each {|v| answer_values.build(target_field => v, 'answer_template_id' => template.id) }
      else
        answer_values.build(target_field => val, 'answer_template_id' => template.id)
      end
    end

    if self.persisted?
      self.save
    end
  end

  def value
    if question.present? and question.answer_templates.present?
      val_container = {}

      question.answer_templates.each do |template|
        target_field = template.data_type
        template_answer_values = answer_values.where(answer_template_id: template.id)

        if template.allow_multiple and template_answer_values.length > 1
          val_container[template.id] = template_answer_values.map{|av| av[target_field] }
        elsif answer_values.length == 1
          val_container[template.id] =  template_answer_values.first[target_field]
        else
          nil
        end
      end

      if val_container.values.length == 1
        val_container.values.first
      else
        val_container
      end

    else
      nil
    end
  end

  def string_value
    val = self.value.clone
    if val.kind_of?(Hash)
      val.each_pair { |k,v| val[k] = v.to_s }
    elsif v.kind_of?(Array)
      v.map(&:to_s)
    else
      v.to_s
    end
  end

  def show_value
    if answer_values.length == 1
      answer_values.first.show_value
    else
      answer_values.map(&:show_value).join(", ")
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
