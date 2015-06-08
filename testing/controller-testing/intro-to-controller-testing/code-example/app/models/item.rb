class Item < ActiveRecord::Base

  validates :name, presence: true

  def as_json(options = {})
    {
      id: self.id,
      name: self.name,
      price: self.price,
      description: self.description
    }
  end

end
