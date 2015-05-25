class Student < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.text :biography
      t.timestamps null: false
    end
  end
end
