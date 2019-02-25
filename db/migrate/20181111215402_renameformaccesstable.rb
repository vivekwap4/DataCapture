class Renameformaccesstable < ActiveRecord::Migration
  def change
    rename_table :formaccess, :formaccesses
  end
end
