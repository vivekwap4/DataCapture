class Updateformnameuniqueness < ActiveRecord::Migration
  def change
    remove_index :forms, :form_name
    change_column :forms, :form_name, :string, :unique => false
  end
end
