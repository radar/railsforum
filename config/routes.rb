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
  map.connect 'topics/reply/:id/:quote', :controller => 'topics', :action => 'reply'
 map.resources :forums do |forums|
 forums.resources :topics, :member => { :reply => :get } do |topics|
  topics.resources :posts
end
end

map.resources :posts

  map.connect ':controller/:action/:id'
end
