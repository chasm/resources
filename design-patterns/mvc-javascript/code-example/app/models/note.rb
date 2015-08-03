class Note < ActiveRecord::Base
  belongs_to :customer
  validates_presence_of :customer
  validates_presence_of :content
end
