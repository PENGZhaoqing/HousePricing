Rails.application.routes.draw do

  root 'houses#map'
  get 'visualisation/scatter'
  # get 'visualisation/bar'
  get 'visualisation/heatmap'
  get 'visualisation/tableau'

  post 'sessions/login' => 'sessions#create'
  delete 'sessions/logout' => 'sessions#destroy'

  resources :houses, only: [:create, :index, :show] do
    collection do
      get 'export'
      get 'filter'
      get 'return_houses'
      get 'return_nums_prices'
    end
    member do
      get 'nearby'
    end
  end

  resources :spiders, only: [:create, :index] do
    collection do
      get 'return_next'
      get 'export_bus'
      get 'export_bus_house'
    end
  end

  resources :hospitals, only: [:create, :index] do
    collection do
      get 'ajax'
    end
  end


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
