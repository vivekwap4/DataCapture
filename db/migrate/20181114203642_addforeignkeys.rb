class Addforeignkeys < ActiveRecord::Migration
  def change
    add_reference :forms, :projects, index: true
  end
end
