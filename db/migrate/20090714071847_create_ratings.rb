class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.references  :graph
      
      t.boolean     :rate
      t.string      :ip
      
      t.timestamps
    end
  end

  def self.down
    drop_table :ratings
  end
end
