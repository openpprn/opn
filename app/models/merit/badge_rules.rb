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


      ##########################
      #### Research Topics #####
      ##########################
      # Inquisitor Badges
      grant_inquisitor_badge_on(1,1..1)
      grant_inquisitor_badge_on(2,2..4)
      grant_inquisitor_badge_on(3,5..9999)
      # Vote Badges
      grant_voter_badge_on(1,1..1)
      grant_voter_badge_on(2,2..4)
      grant_voter_badge_on(3,5..5)


      # FOR COMMENT BADGE, NEED COMMENTS IMPLEMENTED {name: 'discusser', description: 'You commented on 3 topics', custom_fields: { title: 'Discusser', icon: 'fa-comments-o', category: 'research' }},


      ##########################
      #### Health Data #####
      ##########################

      #   {name: 'check-iner', description: 'You\'ve done 40 frequent surveys', custom_fields: { title: 'Frequent Check-iner', icon: 'fa-clock-o', category: 'health_data' }},
          # NEED FREQUENT SURVEY ENGINE UP FOR THIS

      #   {name: 'connector', description: 'You\'ve connected 3 Data Sources', custom_fields: { title: 'Connector', icon: 'fa-link', category: 'health_data' }},
          # NEED VALIDIC UP AND RUNNING TO DO THIS. THIS IS A PURE VALIDIC CALL. THIS WOULD BE DONE AFTER SOME ACTION

      #   {name: 'data-dumper', description: 'Use Your Connected Devices', custom_fields: { title: 'Data Dumper', icon: 'fa-bar-chart', category: 'health_data' }},
          # THIS WOULD HAPPEN AFTER AN IMPORT OF VALIDIC

      #   {name: 'sherlock', description: 'Investigate and graph your data', custom_fields: { title: 'Sherlock', icon: 'fa-search', category: 'health_data' }},
          # I'LL HAVE TO LOOK AND SEE WHAT ACTIONS ONE CAN TAKE ON THE UI TO INVESTIGATE THIS DATA


      ##########################
      #### Members #####
      ##########################
      grant_on 'members#update_profile', badge: 'socialite', model_name: 'social_profile', to: :user, temporary: true do |social_profile|
        social_profile.present? && social_profile.show_location
      end
      grant_on 'members#update_profile', badge: 'greeter', model_name: 'social_profile', to: :user, temporary: true do |social_profile|
        social_profile.present? && social_profile.show_publicly?
      end


    end


    # Helper Methods
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





# ### FOR A CRON JOB: whenever gem?
# # NEED A QUERY EFFICIENT WAY TO SORT ALL RESEARCH TOPICS AND TO DISCOVER THE TOP 10/25/50% list of voted topics
# grant_on 'votes#vote', badge: 'voter', temporary: true, do |vote|
#   vote.research_topic && vote.research_topic.sort { |r,s| r.votes.count > s.votes.count }.first(ResearchTopic.count / 2).include?(vote.research_topic) # RESEARCH TOPIC IN TOP 25%
# end
# # THIS WILL BE A QUERY TO THE PARTNERS OODT SURVEYS COMPLETED / OFFERRED LIST
# # {name: 'dutiful-citizen', description: 'You\'ve responded to 10 biannual surveys', custom_fields: { title: 'Dutiful Citizen', icon: 'fa-list-ul', category: 'research' }},
# grant_on 'votes#vote', badge: 'voter', temporary: true, do |vote|
#   #sadsad
# end
