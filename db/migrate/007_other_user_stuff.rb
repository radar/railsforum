class OtherUserStuff < ActiveRecord::Migration
  def self.up
	  add_column :users, :login_time, :datetime
	  add_column :users, :banned_by, :integer
	  add_column :users, :ban_time, :datetime
	  add_column :users, :ban_reason, :string
	  create_table :banned_ips do |t|
	  t.column 'ip', :string
	  t.column 'reason', :string
	  t.column 'banned_by', :integer
	  end
  end

  def self.down
	  remove_column :users, :login_time
	  
  end
end
