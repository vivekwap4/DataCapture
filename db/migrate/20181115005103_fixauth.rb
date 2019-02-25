class Fixauth < ActiveRecord::Migration
  def change
    remove_column :researchers, :email, :string
    remove_column :dataentries, :email, :string

    add_reference :dataentries, :authentications, index: true
    add_reference :researchers, :authentications, index: true
  end
end
