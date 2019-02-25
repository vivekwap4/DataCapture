class Fixprojectforeignkey < ActiveRecord::Migration
  def change
    remove_column :projects, :researcher_id, :integer

    add_reference :projects, :researchers, index: true
  end
end
