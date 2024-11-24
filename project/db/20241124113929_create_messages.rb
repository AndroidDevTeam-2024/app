class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.datetime :date
      t.string :content
      t.integer :publisher
      t.integer :acceptor

      t.timestamps
    end
  end
end
