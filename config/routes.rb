Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Static Pages
  root 'static#home'
  get 'about' => 'static#about'
  get 'external_link_warning' => 'static#external_link_warning'
  get 'privacy' => 'static#privacy'
  get 'terms' => 'static#terms'


  # Research Section
  get 'research_topics' => 'research#research_topics'
  get 'research_question' => 'research#research_question'
  get 'research_karma' => 'research#research_karma'
  get 'research_surveys' => 'research#research_surveys'
  get 'data_connections' => 'research#data_connections'
  get 'new_question' => 'research#new_question'


  # Health Data Section
  get 'data_explore' => 'health_data#explore'
  get 'data_intro' => 'health_data#intro'
  get 'data_reports' => 'health_data#reports'
  get 'data_medications' => 'health_data#medications'



  # Social Section
  get 'social' => 'social#overview'
  get 'social_profile' => 'social#profile'
  get 'social_discussion' => 'social#discussion' # myapnea


  # Blog Section
  get 'blog' => 'blog#blog'
  get 'blog_findings' => 'blog#blog_findings'


  # Account Section
  get 'account' => 'account#account'
  get 'account_export' => 'account#account_export'
  get 'consent' => 'account#consent'


  # Admin Section
  get 'admin' => 'admin#admin_users'
  get 'admin_users' => 'admin#admin_users'
  get 'admin_surveys' => 'admin#admin_surveys'
  get 'admin_blog' => 'admin#admin_blog'
  get 'admin_notifications' => 'admin#admin_notifications'
  get 'admin_research_topics' => 'admin#admin_research_topics'



  match 'add_role', to: "admin#add_role_to_user", via: :post, as: :add_role
  match 'remove_role', to: "admin#remove_role_from_user", via: :post, as: :remove_role


  # Development/System
  get 'pprn' => 'application#toggle_pprn_cookie'





  # Surveys
  get 'surveys/:question_flow_id', to: 'surveys#start_survey', as: :start_survey
  get 'surveys/:answer_session_id/:question_id', to: 'surveys#ask_question', as: :ask_question
  match 'surveys/process_answer', to: 'surveys#process_answer', via: :post, as: :process_answer
  get 'surveys/report/:answer_session_id', to: 'surveys#show_report', as: :show_report

  # Voting on Questions
  resources :questions
  match 'vote', to: 'votes#vote', via: :post, as: :vote




  devise_for :user
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
end
