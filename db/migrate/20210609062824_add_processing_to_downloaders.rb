class AddProcessingToDownloaders < ActiveRecord::Migration[6.1]
  def change
    add_column :downloaders, :processing_status, :boolean
  end
end
