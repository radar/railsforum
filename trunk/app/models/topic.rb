class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum
  has_many :posts, :dependent => :destroy
  
  #makes error_messages_for return the wrong number of errors.
  validates_associated :posts, :message => nil
  validates_length_of :subject, :minimum => 4
  
  def validates_associated_post_records; end
end
