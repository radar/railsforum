ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  map.root :controller => "forums"
  map.connect 'admin', :controller => "admin/index", :action => "index"
  map.connect 'accounts/user/:login', :controller => 'accounts', :action => 'user'
  map.connect 'topics/reply/:id/:quote', :controller => 'topics', :action => 'reply'
 
  map.namespace :admin do |admin|
    admin.resources :ranks
    admin.resources :accounts, :collection => { :ban_ip => :get }
    admin.resources :styles, :member => { :make_default => :put }
    admin.resources :forums, :collection => { :list => :get }
  end
  
  #FIXME
  map.connect '/admin/chronic', :controller => "/admin/chronic"
 
 map.resources :forums, :collection => { :list => :get } do |forums|
 forums.resources :topics, :collection => { :moderate => :post }, :member => { :reply => :get, :unlock => :get, :lock => :get } do |topics|
  topics.resources :posts
end
end
map.resources :messages, :member => { :reply => :get }, :collection => { :send_reply => :post, :sent => :get }
map.resources :posts

  #FIXME
  #This is ugly!
  
  map.connect 'accounts/:page', :controller => "accounts", :action => "index"
  map.connect 'forums/:id/:page', :controller => "forums", :action => "show"

  map.connect ':controller/:action/:id'
end
