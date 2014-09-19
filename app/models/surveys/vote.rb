class Vote < ActiveRecord::Base
  belongs_to :question
  belongs_to :user



  def self.popular_research_questions
    res = Vote.select("questions.id as question_id, sum(votes.rating) as rating").where("groups.name = 'Research Questions'").joins("full outer join questions on votes.question_id = questions.id").joins("full outer join groups on questions.group_id = groups.id").group("questions.id")
    process_rq_results(res)
  end

  def self.user_research_questions(user)
    res = Vote.select("question_id as question_id, sum(rating) as rating").where(user_id: user.id, rating: 1).group("question_id")
    process_rq_results(res)
  end

  def self.new_research_questions
    res = Vote.select("questions.id as question_id, questions.created_at as created_at, sum(votes.rating) as rating").where("groups.name = 'Research Questions'").joins("full outer join questions on votes.question_id = questions.id").joins("full outer join groups on questions.group_id = groups.id").group("questions.id, questions.created_at")

    res.map {|question| {question: Question.find(question.question_id), created_at: question.created_at, rating: question.rating || 0}}.sort {|q1, q2| q1[:created_at] <=> q2[:created_at]}
  end

  private

  def self.process_rq_results(results)
    final_list = results.map {|question| {question: Question.find(question.question_id), rating: question.rating || 0}}.sort do |q1, q2|
      comp = q2[:rating] <=> q1[:rating]
      comp.zero? ? (q1[:question].created_at <=> q2[:question].created_at) : comp

    end
    final_list
  end

end