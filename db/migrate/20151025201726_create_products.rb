class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :image_url
      t.integer :price
      t.integer :stock

      t.timestamps null: false
    end
  end
end
