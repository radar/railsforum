class Style < ActiveRecord::Base
	has_many :users
  
  validates_presence_of :name, :css
def to_s
	css
end
end