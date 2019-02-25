class AddCategoricalColumn < ActiveRecord::Migration
  def change
    add_column :formattributes, :categorical, :boolean, default: false
    create_table 'categoricalformattributes' do |t|
      t.references 'formattributes'
      t.string 'option'
      t.timestamps
    end
  end
end
