class UpdateResults < ActiveRecord::Migration
  def change
    remove_column :resultsstagings, :formattributes_id, :integer
    remove_column :resultsstagings, :column_name, :string
    remove_column :resultsstagings, :value, :string

    add_column :resultsstagings, :tuple, :text
    add_reference :resultsstagings, :forms, index: true
  end
end
