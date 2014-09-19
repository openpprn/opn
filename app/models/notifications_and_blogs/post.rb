class Post < ActiveRecord::Base
  include Authority::Abilities

  require 'acts-as-taggable-on'
  require "kaminari"

  include ::ActionView::Helpers::TextHelper

  scope :blog_posts, -> { where(post_type: "blog") }
  scope :notifications, -> { where(post_type: "notification") }
  scope :viewable, -> { where(state: "accepted").order(:created_at) }

  acts_as_taggable

  belongs_to :user

  def tags=(val)
    tag_list.add(val)
  end

end