# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090717103024) do

  create_table "categories", :force => true do |t|
    t.string   "category"
    t.integer  "median_margin", :default => 0
    t.integer  "total",         :default => 0
    t.integer  "product_id",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "graph_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "graphs", :force => true do |t|
    t.string   "chart_type"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_classes", :force => true do |t|
    t.string   "product_class"
    t.integer  "median_margin"
    t.integer  "total"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_sub_classes", :force => true do |t|
    t.string   "product_class"
    t.integer  "median_margin"
    t.integer  "total"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "category"
    t.string   "product_class"
    t.string   "product_sub_class"
    t.float    "cost"
    t.integer  "margin"
    t.integer  "UPC_code"
    t.integer  "sku"
    t.date     "date_marked_clearance"
    t.text     "description"
    t.integer  "age"
    t.string   "inventory_location"
    t.float    "msrp"
    t.float    "promotional_price"
    t.integer  "model_number"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "graph_id"
    t.boolean  "rate"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
