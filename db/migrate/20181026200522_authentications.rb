class Authentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :email, null: false
      t.string :password, null: false
      t.string :usertype, null: false
      t.string :access, null: false
      t.text :session_token, null: false
      t.text :reset_token
      t.timestamps
    end
  end
end
