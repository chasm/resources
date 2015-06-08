class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :category
      t.string :name
      t.text :description
      t.decimal :price, :precision => 12, :scale => 2
      t.integer :inventory
      t.timestamps null: false
    end
  end
end