class CreateDownloaders < ActiveRecord::Migration[6.1]
  def change
    create_table :downloaders do |t|
      t.string :ftp_path
      t.boolean :rename
      t.string :rename_prefix
      t.belongs_to :setting, null: false, foreign_key: true

      t.timestamps
    end
  end
end
