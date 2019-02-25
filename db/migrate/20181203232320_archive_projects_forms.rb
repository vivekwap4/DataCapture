class ArchiveProjectsForms < ActiveRecord::Migration
  def change
    add_column :forms, :archive, :boolean, :default => false
    add_column :projects, :archive, :boolean, :default => false
  end
end
