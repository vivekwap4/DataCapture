class Updateresultsstaging < ActiveRecord::Migration
  def change
    add_column :resultsstagings, :updateneeded, :boolean, :default => false
  end
end
