class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
	t.column "forum_id", :integer
	t.column "subject", :string
	t.column "user_id", :integer
	t.column "created_at", :datetime
	t.column "locked", :boolean
	t.column "views", :integer
    end
  end

  def self.down
    drop_table :topics
  end
end
