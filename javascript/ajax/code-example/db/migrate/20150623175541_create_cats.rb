class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name
      t.string :product
      t.timestamps null: false
    end
  end
end
