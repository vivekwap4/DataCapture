class Forms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string :form_id
      t.string :project_name
      t.timestamps
    end
    add_index :forms, :form_id, :unique => true
  end
end
