class CreateFileListings < ActiveRecord::Migration[6.1]
  def change
    create_table :file_listings do |t|
      t.string :file_name
      t.string :file_path
      t.datetime :last_modified

      t.timestamps
    end
  end
end
