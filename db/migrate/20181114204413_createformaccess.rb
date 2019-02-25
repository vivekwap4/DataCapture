class Createformaccess < ActiveRecord::Migration
  def change
    create_table 'formsaccesses' do |t|
      t.references 'forms'
      t.references 'dataentries'
    end
  end
end
