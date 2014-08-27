class Post < ActiveRecord::Base
  require 'acts-as-taggable-on'
  require "kaminari"

  include ::ActionView::Helpers::TextHelper

  acts_as_taggable

end