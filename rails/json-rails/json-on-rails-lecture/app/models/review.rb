class Review < ActiveRecord::Base
  belongs_to :item
  validates :body, presence: true
  validates :rating, presence: true
  validates_inclusion_of :rating, in: 1..5
end