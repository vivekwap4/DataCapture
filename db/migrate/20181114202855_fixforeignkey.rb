class Fixforeignkey < ActiveRecord::Migration
  def change
    remove_column :forms, :project_name
    remove_column :formattributes, :form_id
    drop_table :formaccesses
    remove_column :results, :form_id
  end
end
