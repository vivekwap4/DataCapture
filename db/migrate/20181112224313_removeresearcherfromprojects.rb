class Removeresearcherfromprojects < ActiveRecord::Migration
  def change
    remove_column :projects, :researcher, :string
  end
end
