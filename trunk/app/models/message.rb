class Message < ActiveRecord::Base
  belongs_to :to, :class_name => "User", :foreign_key => :to_id
  belongs_to :from, :class_name => "User", :foreign_key => :from_id
  
  def belongs_to_user(id)
	  from_id == id || to_id == id
  end
end
