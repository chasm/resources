class AddImageUrlAndNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :image_url, :string
    add_column :users, :name, :string
  end
end
