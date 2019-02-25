class Addcolumninattributes < ActiveRecord::Migration
  def change
    add_column :categoricalformattributes, :name, :string
  end
end
