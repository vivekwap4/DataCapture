class Formattributes < ActiveRecord::Migration
  def change
    create_table :formattributes do |t|
      t.string 'form_id'
      t.string 'column_name'
      t.string 'column_type'
      t.timestamps
    end
  end
end
