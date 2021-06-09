class AddStartTimeToDownloaders < ActiveRecord::Migration[6.1]
  def change
    add_column :downloaders, :start_time, :datetime
  end
end
