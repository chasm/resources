class ChangeNotesColumnNames < ActiveRecord::Migration
  def change
    rename_column :notes, :user_id, :customer_id
  end
end
