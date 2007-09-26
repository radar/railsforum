class Style < ActiveRecord::Base
	has_many :users
def to_s
	css
end
end