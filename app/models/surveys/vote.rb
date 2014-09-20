class Vote < ActiveRecord::Base
  # Always needs to belong to user
  belongs_to :user

  # Can only belong to ONE of the following
  belongs_to :question
  belongs_to :comment
  belongs_to :post
  belongs_to :research_topic


end