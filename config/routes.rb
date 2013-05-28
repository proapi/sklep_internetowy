SklepRowerowy::Application.routes.draw do

  get 'payments/accepted'
  get 'payments/rejected'
  post 'payments/update'

  Mercury::Engine.routes

  namespace :admin do
    root :to => "orders#index"
    resources :messages, except: [:update, :edit] do
      collection do
        get 'autocomplete_message_name'
      end
    end
    resources :pack_machines do
      collection do
        get 'autocomplete_pack_machine_name'
      end
    end
    resources :reports
    resources :orders do
      collection do
        get 'autocomplete_order_number'
      end
    end
    resources :articles do
      collection do
        get 'autocomplete_article_title'
      end
      resource :photo
    end
    resources :entries do
      collection do
        get 'autocomplete_entry_title'
      end
    end
    resources :photos do
      collection do
        get 'autocomplete_photo_title'
      end
    end
    resources :users do
      collection do
        get 'autocomplete_user_last_name'
      end
    end
    resources :clients do
      collection do
        get 'autocomplete_client_last_name'
      end
    end
    resources :products do
      collection do
        get 'autocomplete_product_name'
        get 'promotions'
      end
      resource :photo
    end
    resources :producers do
      collection do
        get 'autocomplete_producer_name'
      end
    end
    resources :categories do
      collection do
        get 'autocomplete_category_name'
      end
    end
  end

  resources :password_resets
  resources :orders do
    collection do
      get 'basket'
    end
  end
  resources :articles do
    resource :photo
    collection do
      get 'list'
    end
  end
  resources :entries do
    collection do
      get 'site'
    end
  end
  resources :clients
  resources :products do
    resource :photo
    collection do
      get 'promotion'
    end
  end

  #match "products/list_promotions" => "products#list_promotions"
  #match "products/list_sales" => "products#list_promotions"
  #
  #match "main/index/:type/:id/:page" => "main#index", :requirements => {:page => /\d+/}, :page => nil, :id => /\d+/
  #match "main/index/:type" => "main#index"

  match "login_user" => "user_sessions#new", :as => "login_user"
  match "logout_user" => "user_sessions#destroy", :as => "logout_user"

  match "sklep" => "articles#index"

  match "login_client" => "client_sessions#new", :as => "login_client"
  match "logout_client" => "client_sessions#destroy", :as => "logout_client"

  #te przekierowania potrzebne do odtworzenia poprzedniej funkcjonalności z poprzedniej wersji
  match '/main/index/category/:id' => redirect { |params, req| "/products?search%5Bcategories_id_eq%5D=#{params[:id]}" }
  match '/main/index/producer/:id' => redirect { |params, req| "/products?search%5Bproducer_id_eq%5D=#{params[:id]}" }
  match '/main/produkt/:id' => redirect { |params, req| "/products/#{params[:id]}" }

  root :to => "articles#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
  match "*path" => redirect("/")
end
