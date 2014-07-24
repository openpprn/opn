class QuestionHelpMessage < ActiveRecord::Base
  include Localizable

  has_many :questions

  localize :message

end
