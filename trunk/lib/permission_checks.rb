module PermissionChecks
  #ADMIN CHECKING
  def is_admin?
    if logged_in? && current_user.userlvl == 3
      true
    else
      false
    end
  end
  def is_admin_redirect
    unless is_admin?
      flash[:notice] = "You need to be an admin to do that."
      redirect_to :controller => "accounts", :action => "login"
      false
    end
  end
  
  
  #can the user create topics in this forum?
  def can_create_topics?
    id = params[:forum_id].nil? ? params[:id] : params[:forum_id]
    forum = Forum.find(id)
    unless (logged_in? && forum.topics_created_by <= current_user.userlvl) || forum.topics_created_by == 1
      if params[:action] == "new"
        flash[:notice] = "You cannot create a topic in this forum."
        redirect_back_or_default(forum_path(id))
      end
    else
    true
    end
  end
  
  
  #is the user the owner of this post? are they an admin? 
  def is_post_owner_or_admin?(post_id)
    if logged_in? && (Post.find(post_id).user == current_user || current_user.admin?)
      true
    else
      false
    end
  end
  
  #can the user see this?
  def is_viewable?
    forum = Topic.find(params[:id]).forum
    if (logged_in? && forum.is_visible_to <= current_user.userlvl) || forum.is_visible_to == 1
      true
    else
      flash[:notice] = "You are not able to view that."
      redirect_to forums_path
    end
  end
  
  def is_visible?
    forum = Forum.find(params[:id])
     (logged_in? && forum.is_visible_to <= current_user.userlvl) || forum.is_visible_to == 1
  end
  
  
  #"borrowed" from authenticated_system
  def self.included(base)
    base.send :helper_method, :can_create_topics?, :is_post_owner_or_admin?, :is_admin?
  end
  
  
end