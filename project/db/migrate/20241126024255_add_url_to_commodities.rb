class AddUrlToCommodities < ActiveRecord::Migration[7.2]
  def change
    add_column :commodities, :url, :string
  end
end
