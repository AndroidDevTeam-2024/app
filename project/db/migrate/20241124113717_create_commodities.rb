class CreateCommodities < ActiveRecord::Migration[7.2]
  def change
    create_table :commodities do |t|
      t.string :name
      t.decimal :price
      t.string :introduction
      t.integer :business_id
      t.string :homepage
      t.boolean :exist

      t.timestamps
    end
  end
end
