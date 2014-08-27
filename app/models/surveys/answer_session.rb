class AnswerSession < ActiveRecord::Base
  belongs_to :question_flow
  belongs_to :first_answer, class_name: "Answer", foreign_key: "first_answer_id"
  belongs_to :last_answer, class_name: "Answer", foreign_key: "last_answer_id"
  belongs_to :user
  has_many :answer_edges

  def self.most_recent(question_flow_id, user_id)
    answer_sessions = AnswerSession.where(question_flow_id: question_flow_id, user_id: user_id).order(updated_at: :desc)
    answer_sessions.empty? ? nil : answer_sessions.first
  end

  def calculate_status_stats
    completed = completed_path
    remaining = remaining_path

    {
        percent_completed: (completed[:time] / (completed[:time] + remaining[:time])) * 100,
        completed_questions: completed[:distance],
        remaining_questions: remaining[:distance],
        total_questions: completed[:distance] + remaining[:distance],
        completed_time: completed[:time],
        remaining_time: remaining[:time],
        total_time: completed[:time] + remaining[:time]
    }
  end

  def completed_answers
    if first_answer
      Answer.joins(:in_edge).where(answer_session_id: self.id).select{|a| a.in_edge.present? }.append(first_answer)
    else
      []
    end
  end

  def completed?
    remaining_path[:distance] == 0
  end

  def process_answer(question, params)
    # adding should always be at tail!

    # Create answer object
    # Create answer edge from tail to new answer

    #answer_values =


    # Create new or find old answer object
    answer = Answer.where(question_id: question.id, answer_session_id: self.id).first || Answer.new(question_id: question.id, answer_session_id: self.id)

    # Options:
    # If new, create answer values and save
    #   also, since we're always adding new answers at the tail, set edge from end to new answer, and set new end

    # If existing
    ## If value is changing
    ### set new value
    #### if more than one possible route out
    ##### destroy descendents and set last_answer to this one
    #### else, do nothing
    ## else do nothing

    #

=begin
  new record that's also the first answer in answer session:
    - set value
    - save
    - set to first answer
    - set to last answer
  new record in an existing answer session
    - set value
    - save
    - set edge from previous answer
    - set to last answer

  existing record with new value(s) and multiple downstream options and no in edge and is first answer
    - set value
    - save
    - destroy downstream edges
    - set to last answer

  existing record with new value(s) and multiple downstream options and no in edge
    - set value
    - save
    - destroy downstream edges
    - set edge from previous answer
    - set to last answer

  existing record with new value(s) and multiple downstream options and an in edge
    - set value
    - save
    - destroy downstream edges
    - set to last answer

  existing record with new value(s) and one downstream option and no in edge and is first answer
    - set value
    - save

  existing record with new value(s) and one downstream option and no in edge
    - set value
    - save
    - set edge from previous answer
    - set to last answer


  existing record with new value(s) one downstream option and an in edge
    - set value
    - save

  existing record with no new values and is first and no in edge
    - nothing!!

  existing record with no new values and no in edge
    - set edge from previous answer
    - set to last answer

  existing record with no new values and an in edge
    - nothing!!




  new record: do everything


  existing record with
=end
    # New Record: do everything
    answer_modified = false

    if answer.new_record? or answer.string_value != params[question.id.to_s]
      # Set Value and Save
      answer.value = params[question.id.to_s]
      answer.save
      answer_modified = true
    end

    if first_answer_id.blank?
      # if no first answer, set it!
      self[:first_answer_id] = answer.id
      self[:last_answer_id] = answer.id
    elsif answer.in_edge.blank? and self[:first_answer_id] != answer.id
      # No in edge (and not first answer)...you need to set it
      answer_edges.create(parent_answer_id: last_answer.id, child_answer_id: answer.id)
      self[:last_answer_id] = answer.id
    end

    if answer_modified and answer.multiple_options?
      answer.destroy_descendant_edges
      self[:last_answer_id] = answer.id
    end

    self.save
    answer
  end

  def all_answers
    [first_answer] + first_answer.descendants
  end

  def all_reportable_answers
    all_answers.select {|answer| [3].include?(answer.question.question_type.id) and answer.show_value.present? }
  end

  def get_answer(question_id)
    Question.find(question_id).answers.where(answer_session_id: self.id).first
  end

  def started?
    last_answer.present?
  end

  def reset_answers
    if first_answer.present?
      connected_answers = all_answers
      first_answer.destroy_descendant_edges
      self.first_answer = nil
      self.last_answer = nil
      save
      connected_answers.each(&:destroy)
    end
  end

  private

  def completed_path
    time = completed_answers.map(&:question).map(&:time_estimate).reduce(:+) || 0.0
    distance = completed_answers.length

    {time: time, distance: distance}
  end

  def remaining_path

    if last_answer.blank?
      {time: question_flow.total_time, distance: question_flow.total_questions}
    else
      s = last_answer.next_question

      if s
        l = question_flow.leaf

        result = question_flow.find_longest_path(s,l)
        corrections = {time: 0.0, distance: 0}

        {time: result[:time] - corrections[:time], distance: result[:distance] - corrections[:distance]}
      else
        {time: 0.0, distance: 0}
      end
    end
  end

end
