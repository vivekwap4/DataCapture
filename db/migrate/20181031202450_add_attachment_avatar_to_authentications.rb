class AddAttachmentAvatarToAuthentications < ActiveRecord::Migration
  def self.up
    change_table :authentications do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :authentications, :avatar
  end
end
