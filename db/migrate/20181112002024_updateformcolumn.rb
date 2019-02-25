class Updateformcolumn < ActiveRecord::Migration
  def change
    rename_column :forms, :form_id, :form_name
  end
end
