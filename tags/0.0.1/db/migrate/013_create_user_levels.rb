class CreateUserLevels < ActiveRecord::Migration
  def self.up
    create_table :user_levels do |t|
    t.column :name, :string
    end
	UserLevel.create(:name => "User")
	UserLevel.create(:name => "Moderator")
	UserLevel.create(:name => "Administrator")
	rename_column("users","userlvl","user_level_id")
  end

  def self.down
    drop_table :user_levels
    rename_column("users","user_level_id","userlvl")
  end
end
