# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+votes: 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badge (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badge to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badge is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      # If it creates user, grant badge
      # Should be "current_user" after registration for badge to be granted.
      grant_on 'registrations#create', badge: 'just-registered', model_name: 'User'

      # Inquisitor Badges
      grant_inquisitor_badge_on(1,1..1)
      grant_inquisitor_badge_on(2,2..4)
      grant_inquisitor_badge_on(3,5..9999)

      # Vote Badges
      grant_voter_badge_on(1,1..1)
      grant_voter_badge_on(2,2..4)
      grant_voter_badge_on(3,5..5)


      # grant_on 'members#update_profile', badge: 'socialite', temporary: true do |social_profile|
      #   social_profile.present? && social_profile.show_location
      # end


      # If it has 10 comments, grant commenter-10 badge
      # grant_on 'comments#create', badge: 'commenter', level: 10 do |comment|
      #   comment.user.comments.count == 10
      # end

      # If it has 5 votes, grant relevant-commenter badge
      # grant_on 'comments#vote', badge: 'relevant-commenter',
      #   to: :user do |comment|
      #
      #   comment.votes.count == 5
      # end

      # Changes his name by one wider than 4 chars (arbitrary ruby code case)
      # grant_on 'registrations#update', badge: 'autobiographer',
      #   temporary: true, model_name: 'User' do |user|
      #
      #   user.name.length > 4
      # end
    end

    def grant_inquisitor_badge_on(level, range)
      grant_on ['research_topics#create', 'research_topics#destroy'], badge: 'inquisitor', temporary: true, level: level do |research_topic|
        range.include? research_topic.user.research_topics.count
      end
    end

    def grant_voter_badge_on(level, range)
      grant_on 'votes#vote', badge: 'voter', temporary: true, level: level, to: :user do |vote|
        range.include? vote.user.votes.where("rating > 0").count
      end
    end

  end
end
