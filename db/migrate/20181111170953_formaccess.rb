class Formaccess < ActiveRecord::Migration
  def change
    create_table :formaccess do |t|
      t.string 'form_id'
      t.string 'dataentry_id'
      t.timestamps
    end
  end
end
