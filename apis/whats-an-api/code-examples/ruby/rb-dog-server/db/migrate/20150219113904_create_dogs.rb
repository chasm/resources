class CreateDogs < ActiveRecord::Migration
  def change
  	create_table :dogs do |t|
  		t.string :name
  		t.string :image_url
  	end 
  end
end
