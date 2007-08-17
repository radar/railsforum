module PermissionChecks
  #can the user create topics in this forum?
  def can_create_topics?(forum)
   (logged_in? && forum.topics_created_by <= current_user.userlvl) || forum.topics_created_by == 1
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
    if is_visible?(forum)
      return true
    else
      flash[:notice] = "You are not able to view that."
      redirect_to forums_path
    end
  end
  
  def is_visible?(forum)
   (logged_in? && forum.is_visible_to <= current_user.userlvl) || forum.is_visible_to == 1
  end
  
  
  #"borrowed" from authenticated_system
  def self.included(base)
    base.send :helper_method, :can_create_topics?, :is_post_owner_or_admin?
  end
  
  
end