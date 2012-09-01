class CreateProductClasses < ActiveRecord::Migration
  def self.up
    create_table :product_classes do |t|
      t.string :product_class
      t.integer :median_margin
      t.integer :total
      t.references :product
      
      t.timestamps
    end
  end

  def self.down
    drop_table :product_classes
  end
end
