class Comment < ActiveRecord::Base
  belongs_to :post, counter_cache: true, touch: true
  has_many :votes
  belongs_to :research_topic, counter_cache: true, touch: true
end