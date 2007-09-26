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
  map.connect '', :controller => "forums"
  map.connect 'accounts/user/:login', :controller => 'accounts', :action => 'user'
 # map.connect 'topics/reply/:id/:quote', :controller => 'topics', :action => 'reply'
 map.resources :forums, :collection => { :list => :get } do |forums|
 forums.resources :topics, :collection => { :moderate => :post }, :member => { :reply => :get, :unlock => :get, :lock => :get } do |topics|
  topics.resources :posts
end
end
map.resources :messages, :member => { :reply => :get }, :collection => { :send_reply => :post, :sent => :get }
map.resources :posts, :ranks, :styles

  map.connect ':controller/:action/:id'
end
