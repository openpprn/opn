class Group < ActiveRecord::Base
  has_many :questions

  def minimum_set(start_point, question_flow)
    current_q = start_point

    # go to start of group
    while current_q.default_previous_question(question_flow).present? and current_q.default_previous_question(question_flow).group == self
      current_q = current_q.default_previous_question(question_flow)
    end


    min_set = [current_q]

    while (current_q = current_q.default_next_question(question_flow)) and current_q.group == self
      min_set << current_q

    end



    min_set
  end


end