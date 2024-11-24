class AddCommodityToDeals < ActiveRecord::Migration[7.2]
  def change
    add_column :deals, :commodity, :integer
  end
end
