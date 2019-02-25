class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string 'project_name'
      t.string 'research_group'
      t.string 'researcher'
      t.timestamps
      t.references 'researcher'
    end
  end
end

