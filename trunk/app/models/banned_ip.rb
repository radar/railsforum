class BannedIp < ActiveRecord::Base
	belongs_to :user, :class_name => "User", :foreign_key => "banned_by"
end
