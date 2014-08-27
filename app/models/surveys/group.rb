class Group < ActiveRecord::Base
  has_many :questions

  def minimum_set(start_point, question_flow)
    min_set = [start_point]
    current_q = start_point

    while (current_q = current_q.default_next_question(question_flow)) and current_q.group == self
      min_set << current_q

    end

    min_set
  end


end