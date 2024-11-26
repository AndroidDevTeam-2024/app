class AddUrlToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :url, :string
  end
end
