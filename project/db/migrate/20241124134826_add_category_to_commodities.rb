class AddCategoryToCommodities < ActiveRecord::Migration[7.2]
  def change
    add_column :commodities, :category, :string
  end
end
