class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :item
      t.string :title
      t.text :body
      t.integer :rating
      t.timestamps null: false
    end
  end
end