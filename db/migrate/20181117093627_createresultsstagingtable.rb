class Createresultsstagingtable < ActiveRecord::Migration
  def change
    create_table :resultsstagings do |t|
      t.string 'column_name'
      t.string 'value'
      t.references 'formattributes'
      t.timestamps
    end
    add_index :resultsstagings, :formattributes_id
  end
end
