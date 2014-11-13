# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongoid
  # config.orm = :active_record

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  # Define :user_model_name. This model will be used to grant badge if no
  # `:to` option is given. Default is 'User'.
  # config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  # config.current_user_method = 'current_user'
end

# Create application badges (uses https://github.com/norman/ambry)

# Multi-Level Badges
inquisitor_attr = {name: 'inquisitor', custom_fields: { title: 'Inquisitor', icon: 'fa-question-circle', category: 'research' } }
voter_attr = {name: 'voter', custom_fields: { title: 'Voter', icon: 'fa-check-circle-o', category: 'research' } }

badges = [inquisitor_attr.merge({level: 1, description: "level one son!"}),
  inquisitor_attr.merge({level: 2, description: "level two blue!"}),
  inquisitor_attr.merge({level: 3, description: "level three bee!"}),
  voter_attr.merge({level: 1, description: "newbie voter"}),
  voter_attr.merge({level: 2, description: "voted twice"}),
  voter_attr.merge({level: 3, description: "you've voted like everything!"}),
  {name: 'just-registered', description: 'You joined! You\'re a boss!', custom_fields: { title: 'You Joined!', icon: 'fa-user', category: 'home' }},
  {name: 'socialite', description: 'You socialize like a boss!', custom_fields: { title: 'Socialite', icon: 'fa-user-group', category: 'members' }}
]

badge_id = 1

badges.each do |attrs|
  Merit::Badge.create!(attrs.merge({id: badge_id}))
  badge_id += 1
end