# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141013233527) do

  create_table "brands", force: true do |t|
    t.string "name"
  end

  add_index "brands", ["name"], name: "index_brands_on_name", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", using: :btree

  create_table "categorizations", force: true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "colorizations", force: true do |t|
    t.string "name"
  end

  add_index "colorizations", ["name"], name: "index_colorizations_on_name", using: :btree

  create_table "configurations", force: true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "configurations", ["key"], name: "index_configurations_on_key", unique: true, using: :btree

  create_table "fashion_fly_editor_collection_items", force: true do |t|
    t.integer  "collection_id"
    t.integer  "item_id"
    t.integer  "x_coordinate"
    t.integer  "y_coordinate"
    t.float    "scale_x"
    t.float    "scale_y"
    t.float    "rotation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fashion_fly_editor_collections", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "affi_shop"
    t.string   "affi_code"
    t.string   "name"
    t.string   "number"
    t.text     "description"
    t.integer  "brand_id"
    t.integer  "colorization_id"
    t.string   "ean"
    t.decimal  "price",                precision: 10, scale: 2
    t.string   "shippingHandlingCost"
    t.string   "lastModified"
    t.string   "image"
    t.string   "original"
    t.string   "deliveryTime"
    t.string   "currencyCode"
    t.text     "deepLink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scopes", force: true do |t|
    t.string   "country_code"
    t.string   "locale"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scopes", ["country_code"], name: "index_scopes_on_country_code", unique: true, using: :btree

end
