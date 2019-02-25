class Updateresulttable < ActiveRecord::Migration
  def change
    remove_column :results, :formattributes_id, :integer
    remove_column :results, :column_name, :string
    remove_column :results, :value, :string

    add_column :results, :tuple, :text
    add_reference :results, :forms, index: true
  end
end
