class AddIndextoSessionColumn < ActiveRecord::Migration
  def change
    add_index :authentications, :session_token
  end
end
