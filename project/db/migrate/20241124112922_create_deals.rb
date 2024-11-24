class CreateDeals < ActiveRecord::Migration[7.2]
  def change
    create_table :deals do |t|
      t.integer :seller
      t.integer :customer
      t.datetime :date
      t.string :comment

      t.timestamps
    end
  end
end
