Rails.application.routes.draw do


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Static Pages
  root 'static#home'
  get 'about' => 'static#about'
  get 'external_link_warning' => 'static#external_link_warning'
  get 'terms' => 'static#terms'
  get 'theme' => 'static#theme'
  get 'version' => 'static#version'

  # MyApnea Specific
  get 'learn' => 'static#learn'
  get 'share' => 'static#share'
  get 'research' => 'static#research'
  get 'faqs' => 'static#faqs'
  get 'team' => 'static#team'
  match 'user_dashboard', to: 'account#dashboard', as: :user_dashboard, via: :get
  match 'consent', to: "account#consent", as: :consent, via: [:get, :post]
  match 'social/discussion/terms_and_conditions', to: 'account#terms_and_conditions', via: :get, as: :terms_and_conditions
  match 'privacy_policy', to: "account#privacy_policy", as: :privacy, via: [:get, :post]


  # Research Section
  get 'research_topics' => 'research#research_topics'
  match 'research_question/:id', to: "research#research_question", as: :view_research_question, via: :get
  get 'research_karma' => 'research#research_karma'
  get 'research_today' => 'research#research_today'
  get 'research_surveys' => 'research#research_surveys', as: :surveys
  get 'data_connections' => 'research#data_connections'
  get 'new_question' => 'research#new_question'
  get 'research_questions' => 'research#research_questions'
  get 'vote_counter' => 'research#vote_counter'

  # Surveys
  get 'research_surveys/report/:answer_session_id', to: 'surveys#show_report', as: :survey_report
  get 'research_surveys/:question_flow_id', to: 'surveys#start_survey', as: :start_survey
  get 'research_surveys/:answer_session_id/:question_id', to: 'surveys#ask_question', as: :ask_question
  match 'research_surveys/process_answer', to: 'surveys#process_answer', via: :post, as: :process_answer
  get 'questions/frequencies(/:question_id/:answer_session_id)', to: "questions#frequencies", as: :question_frequencies, format: :json


  # Health Data Section
  get 'data_explore' => 'health_data#explore'
  get 'data_reports' => 'health_data#reports'
  get 'data_medications' => 'health_data#medications'
  get 'data_intro' => 'health_data#intro'



  # Social Section
  match 'social', to: 'social#overview', via: :get, as: 'social' # show
  match 'social/profile', to: 'social#profile', as: 'social_profile', via: :get #edit
  match 'social/profile', to: 'social#update_profile', as: 'update_social_profile', via: [:put, :post, :patch] # update
  match 'locations', via: :get, as: :locations, format: :json, to: 'social#locations'


  # Blog Section
  get 'blog' => 'blog#blog'
  get 'blog_findings' => 'blog#blog_findings'


  # Account Section
  get 'account' => 'account#account'
  get 'account_export' => 'account#account_export'
  match 'update_account', to: 'account#update', as: 'update_account', via: :patch
  match 'change_password', to: 'account#change_password', as: 'change_password', via: :patch


  # Admin Section
  get 'admin' => 'admin#users'
  match 'admin/users', to: 'admin#users', as: 'admin_users', via: [:get, :post]
  get 'admin/surveys' => 'admin#surveys', as: 'admin_surveys'
  get 'admin/blog' => 'admin#blog', as: 'admin_blog'
  get 'admin/notifications' => 'admin#notifications', as: 'admin_notifications'
  get 'admin/research_topics' => 'admin#research_topics', as: 'admin_research_topics'

  match 'add_role', to: "admin#add_role_to_user", via: :post, as: :add_role, format: :js
  match 'remove_role', to: "admin#remove_role_from_user", via: :post, as: :remove_role, format: :js
  match 'destroy_user', to: "admin#destroy_user", via: :post, as: :destroy_user, format: :js

  # Development/System
  get 'pprn' => 'application#toggle_pprn_cookie'

  # Voting on Questions
  resources :questions
  match 'vote', to: 'votes#vote', via: :post, as: :vote


  devise_for :user, controllers: { registrations: 'registrations' }



# # Authentication
#   devise_for :user, skip: [:sessions, :passwords, :confirmations, :registrations]
#   as :user do
#     # session handling
#     get     '/login'  => 'devise/sessions#new',     as: 'new_user_session'
#     post    '/login'  => 'devise/sessions#create',  as: 'user_session'
#     delete  '/logout' => 'devise/sessions#destroy', as: 'destroy_user_session'

#     # joining
#     # get   '/join' => 'devise/registrations#new',    as: 'new_user_registration'
#     # post  '/join' => 'devise/registrations#create', as: 'user_registration'

#     # scope '/account' do
#     #   # password reset
#     #   get   '/reset-password'        => 'devise/passwords#new',    as: 'new_user_password'
#     #   put   '/reset-password'        => 'devise/passwords#update', as: 'user_password'
#     #   post  '/reset-password'        => 'devise/passwords#create'
#     #   get   '/reset-password/change' => 'devise/passwords#edit',   as: 'edit_user_password'

#     #   # confirmation
#     #   get   '/confirm'        => 'devise/confirmations#show',   as: 'user_confirmation'
#     #   post  '/confirm'        => 'devise/confirmations#create'
#     #   get   '/confirm/resend' => 'devise/confirmations#new',    as: 'new_user_confirmation'

#     #   # settings & cancellation
#     #   get '/cancel'   => 'devise/registrations#cancel', as: 'cancel_user_registration'
#     #   get '/settings' => 'devise/registrations#edit',   as: 'edit_user_registration'
#     #   put '/settings' => 'devise/registrations#update'

#     #   # account deletion
#     #   delete '' => 'devise/registrations#destroy', as: 'destroy_user_registration'
#     # end
#   end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # This line mounts Forem's routes at /forums by default.
  # This means, any requests to the /forums URL of your application will go to Forem::ForumsController#index.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Forem relies on it being the default of "forem"
  mount Forem::Engine, :at => '/social/discussion'

end
