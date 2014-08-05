Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#index'

  # Front-end Prototype Pages
  get 'about' => 'pages#about'
  get 'account' => 'pages#account'
  get 'blog' => 'pages#blog'
  get 'connections' => 'pages#connections'
  get 'consent' => 'pages#consent'
  get 'data' => 'pages#data'
  get 'data_learn' => 'pages#data_learn'
  get 'data_reports' => 'pages#data_reports'

  get 'discussion' => 'pages#discussion' # myapnea
  get 'external_link_warning' => 'pages#external_link_warning'
  get 'findings' => 'pages#findings'
  get 'insights' => 'pages#insights'
  get 'new_question' => 'pages#new_question'
  get 'pprn' => 'pages#toggle_pprn_cookie'
  get 'privacy' => 'pages#privacy'
  get 'req' => 'pages#req'
  get 'research' => 'pages#research'
  get 'research_question' => 'pages#research_question'
  get 'social' => 'pages#social'
  get 'social_profile' => 'pages#social_profile'
  get 'terms' => 'pages#terms'

  # Surveys
  get 'surveys' => 'surveys#index'
  get 'surveys/:question_flow_id', to: 'surveys#start_survey', as: :start_survey
  get 'surveys/:answer_session_id/:question_id', to: 'surveys#ask_question', as: :ask_question
  match 'surveys/process_answer', to: 'surveys#process_answer', via: :post, as: :process_answer
  get 'surveys/report/:answer_session_id', to: 'surveys#show_report', as: :show_report

  # Voting on Questions
  resources :questions
  match 'vote', to: 'votes#vote', via: :post, as: :vote

  # Admin
  match 'admin(/:tab)' => 'admin#dashboard', as: :admin, via: [:get, :post]

  match 'add_role', to: "admin#add_role_to_user", via: :post, as: :add_role
  match 'remove_role', to: "admin#remove_role_from_user", via: :post, as: :remove_role

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
