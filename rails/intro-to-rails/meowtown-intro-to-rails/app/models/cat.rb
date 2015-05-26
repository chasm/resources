class Cat < ActiveRecord::Base

    validates :name, presence: true
    validates :life_story, presence: true
    validates :image_url, presence: true

    def lose_a_life!
      if self.lives > 1
        self.lives -= 1
        self.save
      else 
        self.destroy
      end
    end

end