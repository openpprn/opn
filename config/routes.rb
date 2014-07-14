Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#index'

  # Front-end Prototype Pages
  get 'about' => 'pages#about'
  get 'account' => 'pages#account'
  get 'admin' => 'pages#admin'
  get 'blog' => 'pages#blog'
  get 'connections' => 'pages#connections'
  get 'consent' => 'pages#consent'
  get 'data' => 'pages#data'
  get 'discussion' => 'pages#discussion' # sapcon
  get 'external_link_warning' => 'pages#external_link_warning'
  get 'findings' => 'pages#findings'
  get 'insights' => 'pages#insights'
  get 'join' => 'pages#join'
  get 'login' => 'pages#login'
  get 'new_question' => 'pages#new_question'
  get 'pprn' => 'pages#pprn'
  get 'privacy' => 'pages#privacy'
  get 'req' => 'pages#req'
  get 'research' => 'pages#research'
  get 'research_question' => 'pages#research_question'
  get 'social' => 'pages#social'
  get 'survey' => 'pages#survey'
  get 'terms' => 'pages#terms'


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
