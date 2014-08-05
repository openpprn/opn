class QuestionHelpMessage < ActiveRecord::Base
  include Localizable

  include Authority::Abilities
  self.authorizer_name = "AdminAuthorizer"

  has_many :questions

  localize :message

end
