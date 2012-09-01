class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :category
      t.string :product_class
      t.string :product_sub_class
      t.float :cost
      t.float :margin
      t.integer :UPC_code, :limit => 12
      t.string :sku
      t.date :date_marked_clearance
      t.text :description
      t.integer :age
      t.string :inventory_location
      t.float :msrp
      t.float :promotional_price
      t.integer :model_number
      t.string :color
      
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
