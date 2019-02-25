class Addforeignkeys2 < ActiveRecord::Migration
  def change
    add_reference :formattributes, :forms, index: true
    add_reference :results, :formattributes, index: true
  end
end
