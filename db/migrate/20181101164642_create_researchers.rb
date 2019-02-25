class CreateResearchers < ActiveRecord::Migration
  def change
    create_table :researchers do |t|
      t.string :firstname, null: false
      t.string :lastname,  null: false
      t.string :researchgroup, null: false
      t.string :email, null: false
      t.timestamps
    end

  end
end
