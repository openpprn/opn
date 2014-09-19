module SurveysHelper
  def previous_question_path(answer)
    if answer.answer_session.first_answer.nil? or answer.answer_session.first_answer == answer
      start_survey_path(question_flow_id: answer.answer_session.question_flow.id)
    elsif answer.previous_answer.present?
      ask_question_path(question_id: answer.previous_answer.question.id, answer_session_id: answer.answer_session.id)
    else
      ask_question_path(question_id: answer.answer_session.last_answer.question.id, answer_session_id: answer.answer_session.id)
    end
  end

  def have_checked?(answer, answer_template, val)
    if answer.present? and answer.value.present? and answer.value[answer_template.id].present?
      saved_val = answer.value[answer_template.id]

      if saved_val.kind_of?(Array)
        saved_val.include? val
      else
        saved_val == val
      end
    else
      false
    end

  end

  def start_or_resume_survey(question_flow, answer_session = nil)
    if answer_session.present? and answer_session.started?
      ask_question_path(answer_session_id: answer_session.id, question_id: answer_session.last_answer.next_question.id)
    else
      start_survey_path(question_flow_id: question_flow.id)
    end
  end

  def next_survey?(current_qf)
    QuestionFlow.where(status: "show").select{|qf| qf.id != current_qf.id }.first.present?

  end

  def go_to_next_survey(user, current_qf)
    next_qf = QuestionFlow.where(status: "show").select{|qf| qf.id != current_qf.id }.first
    as = user.answer_sessions.where(question_flow_id: next_qf.id)

    start_or_resume_survey(next_qf, as)
  end

  def bmi(height, weight)
    (weight/height**2 * 703).round
  end

  def bmi_category(bmi)
    if bmi < 18.5
      "Underweight"
    elsif bmi < 25
      "Normal"
    elsif bmi < 30
      "Overweight"
    else
      "Obese"
    end
  end


  def conditional_tag(condition, tag, attributes, &block)
    if condition
      haml_tag :div, attributes, &block
    else
      haml_concat capture_haml(&block)
    end
  end

  def show_questions
    # show self

    # show descendants


  end
end
