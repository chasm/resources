class Item < ActiveRecord::Base
  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
end