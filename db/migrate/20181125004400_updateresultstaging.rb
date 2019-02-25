class Updateresultstaging < ActiveRecord::Migration
  def change
    add_column :resultsstagings, :jsondata, :jsonb
    add_column :results, :jsondata, :jsonb
  end
end
