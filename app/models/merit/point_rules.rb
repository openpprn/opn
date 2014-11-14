# Be sure to restart your server when you modify this file.
#
# Points are a simple integer value which are given to "meritable" resources
# according to rules in +app/models/merit/point_rules.rb+. They are given on
# actions-triggered, either to the action user or to the method (or array of
# methods) defined in the +:to+ option.
#
# 'score' method may accept a block which evaluates to boolean
# (recieves the object as parameter)

module Merit
  class PointRules
    include Merit::PointRulesMethods

    def initialize
      score 50, :on => 'registrations#create', model_name: "User"

      # Give points to research topic authors that get upvoted
      score 25, :on => 'votes#vote', :to => [:research_topic_author] do |vote|
        vote.research_topic.present? && (vote.rating > 0)
      end

      score 20, :on => 'research_topics#create'

      score 10, :on => 'comments#create'


      # Add points for every badge awarded? How?

      # Add some scoring here for data points that come from their connected devices, etc.

      # Add some scoring here for surveys that are anwered, longitudinal

      # Add some scoring here for surveys (freqent) that are done freq
    end
  end
end
