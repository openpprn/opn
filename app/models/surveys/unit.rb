class Unit < ActiveRecord::Base
  include Localizable

  has_many :questions
  localize :name

end