class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name
      t.text :life_story
      t.string :image_url
      t.integer :lives, default: 9

      t.timestamps null: false
    end
  end
end