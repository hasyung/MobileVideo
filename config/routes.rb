MobileVideo::Application.routes.draw do
  
 devise_for :users,
            :path => "",
            :path_names => { :sign_in => 'login', :sign_out => 'logout' },
            :skip => [:passwords, :registrations],
            :controllers => { :sessions => 'admin/sessions' }

  root :to => 'videos#index'
  
  resources :videos, :only => [:index, :show, :update] do
    post 'search', :on => :collection
    get 'page/:page', :action => :search, :on => :collection    
    get 'publish/:status', :action => :publish, :on => :member, :as => :publish
  end

  namespace :admin do
    root :to => 'videos#index'
    resources :videos do
      post 'search', :on => :collection
      post 'destroies', :on => :collection
      get 'page/:page', :action => :search, :on => :collection 
    end
    resources :comments, :only => [:index]
  end
end
