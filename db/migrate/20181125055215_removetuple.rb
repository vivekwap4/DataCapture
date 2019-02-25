class Removetuple < ActiveRecord::Migration
  def change
    remove_column :results, :tuple, :text
    remove_column :resultsstagings, :tuple, :text
  end
end
