module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments
  end

  module ClassMethods
  end
end
