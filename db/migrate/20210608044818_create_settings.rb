class CreateSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :settings do |t|
      t.string :instance_name
      t.string :ftp_server
      t.integer :ftp_port
      t.string :ftp_password

      t.timestamps
    end
  end
end
