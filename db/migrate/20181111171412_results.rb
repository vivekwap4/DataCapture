class Results < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string 'form_id'
      t.string 'column_name'
      t.string 'value'
      t.timestamps
    end
  end
end
