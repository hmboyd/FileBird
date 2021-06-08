class AddUsernameToSettings < ActiveRecord::Migration[6.1]
  def change
    add_column :settings, :username, :string
  end
end
