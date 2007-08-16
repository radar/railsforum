class SomeMoreUserStuff < ActiveRecord::Migration
  def self.up
    add_column :users, :location, :string
    add_column :users, :description, :text
    add_column :users, :website, :text
  end
  
  def self.down
  end
end
