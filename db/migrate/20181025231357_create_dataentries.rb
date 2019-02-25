class CreateDataentries < ActiveRecord::Migration
  def change
    create_table :dataentries do |t|
      t.string :firstname, null: false
      t.string :lastname
      t.string :profile, null: false
      t.string :institution, null: false
      t.string :email, null: false
      t.timestamps
    end
  end
end
