class AddIntervalToDownloaders < ActiveRecord::Migration[6.1]
  def change
    add_column :downloaders, :interval, :integer
  end
end
