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

ActiveRecord::Schema.define(version: 20150405152657) do

  create_table "affiliates", force: :cascade do |t|
    t.string   "file",                limit: 255
    t.string   "name",                limit: 255
    t.boolean  "ready",               limit: 1
    t.integer  "scope_id",            limit: 4
    t.string   "item_tag",            limit: 255
    t.string   "category_tag",        limit: 255
    t.string   "category_split_char", limit: 255
    t.string   "ean_tag",             limit: 255
    t.string   "image_tag",           limit: 255
    t.string   "name_tag",            limit: 255
    t.string   "number_tag",          limit: 255
    t.string   "description_tag",     limit: 255
    t.string   "brand_tag",           limit: 255
    t.string   "price_tag",           limit: 255
    t.string   "shipping_cost_tag",   limit: 255
    t.string   "last_modified_tag",   limit: 255
    t.string   "delivery_time_tag",   limit: 255
    t.string   "currency_code_tag",   limit: 255
    t.string   "link_tag",            limit: 255
    t.string   "importer",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "importing",           limit: 1,   default: false
    t.integer  "percent",             limit: 4,   default: 0
    t.string   "logo",                limit: 255
    t.boolean  "free_shipping",       limit: 1,   default: false
    t.boolean  "pay_invoice",         limit: 1,   default: false
    t.boolean  "premium",             limit: 1,   default: false
    t.boolean  "replace_only_images", limit: 1,   default: false
    t.integer  "start_from_id",       limit: 4,   default: 0
    t.integer  "skip_items",          limit: 4,   default: 0
  end

  add_index "affiliates", ["importing"], name: "index_affiliates_on_importing", using: :btree
  add_index "affiliates", ["scope_id"], name: "index_affiliates_on_scope_id", using: :btree

  create_table "authentication_providers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "position",   limit: 4,   default: 0
  end

  add_index "authentication_providers", ["name"], name: "index_name_on_authentication_providers", using: :btree
  add_index "authentication_providers", ["position"], name: "index_authentication_providers_on_position", using: :btree

  create_table "average_caches", force: :cascade do |t|
    t.integer  "rater_id",      limit: 4
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "avg",           limit: 24,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banners", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "banner",         limit: 255
    t.text     "link",           limit: 65535
    t.string   "preview_ids",    limit: 255
    t.string   "previews_model", limit: 255
    t.integer  "scope_id",       limit: 4
    t.integer  "position",       limit: 4,     default: 0
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "banners", ["position"], name: "index_banners_on_position", using: :btree
  add_index "banners", ["scope_id"], name: "index_banners_on_scope_id", using: :btree

  create_table "brands", force: :cascade do |t|
    t.string "name", limit: 255
  end

  add_index "brands", ["name"], name: "index_brands_on_name", using: :btree

  create_table "brands_categories", force: :cascade do |t|
    t.integer "brand_id",    limit: 4
    t.integer "category_id", limit: 4
  end

  add_index "brands_categories", ["brand_id", "category_id"], name: "by_brand_category", unique: true, using: :btree
  add_index "brands_categories", ["brand_id"], name: "index_brands_categories_on_brand_id", using: :btree
  add_index "brands_categories", ["category_id"], name: "index_brands_categories_on_category_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "category_id", limit: 4
    t.string   "slug",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "scope_id",    limit: 4
    t.boolean  "main_taxon",  limit: 1
    t.integer  "position",    limit: 4
    t.boolean  "published",   limit: 1,   default: false
    t.boolean  "leaf",        limit: 1
  end

  add_index "categories", ["category_id"], name: "index_categories_on_category_id", using: :btree
  add_index "categories", ["leaf"], name: "index_categories_on_leaf", using: :btree
  add_index "categories", ["main_taxon"], name: "index_categories_on_main_taxon", using: :btree
  add_index "categories", ["position"], name: "index_categories_on_position", using: :btree
  add_index "categories", ["published"], name: "index_categories_on_published", using: :btree
  add_index "categories", ["scope_id"], name: "index_categories_on_scope_id", using: :btree
  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree

  create_table "categories_icons", force: :cascade do |t|
    t.integer "category_id", limit: 4
    t.integer "icon_id",     limit: 4
  end

  add_index "categories_icons", ["category_id"], name: "index_categories_icons_on_category_id", using: :btree
  add_index "categories_icons", ["icon_id"], name: "index_categories_icons_on_icon_id", using: :btree

  create_table "categorizations", force: :cascade do |t|
    t.integer  "product_id",  limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categorizations", ["category_id", "product_id"], name: "index_categorizations_on_category_id_and_product_id", using: :btree
  add_index "categorizations", ["category_id"], name: "index_categorizations_on_category_id", using: :btree
  add_index "categorizations", ["product_id"], name: "index_categorizations_on_product_id", using: :btree

  create_table "color_words", force: :cascade do |t|
    t.integer "scope_id",        limit: 4
    t.integer "colorization_id", limit: 4
    t.string  "sentence_part",   limit: 255
    t.string  "descriptive",     limit: 255
  end

  add_index "color_words", ["colorization_id"], name: "index_color_words_on_colorization_id", using: :btree
  add_index "color_words", ["scope_id"], name: "index_color_words_on_scope_id", using: :btree

  create_table "colorizations", force: :cascade do |t|
    t.string "name",          limit: 255
    t.string "word",          limit: 255
    t.string "oposite_color", limit: 255
  end

  add_index "colorizations", ["name"], name: "index_colorizations_on_name", using: :btree

  create_table "colorizations_words", force: :cascade do |t|
    t.integer "colorization_id", limit: 4
    t.integer "word_id",         limit: 4
  end

  add_index "colorizations_words", ["colorization_id"], name: "index_colorizations_words_on_colorization_id", using: :btree
  add_index "colorizations_words", ["word_id"], name: "index_colorizations_words_on_word_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50,    default: ""
    t.text     "comment",          limit: 65535
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.integer  "user_id",          limit: 4
    t.string   "role",             limit: 255,   default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "configurations", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "configurations", ["key"], name: "index_configurations_on_key", unique: true, using: :btree

  create_table "contests", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "banner",     limit: 255
    t.string   "slug",       limit: 255
    t.text     "body",       limit: 65535
    t.integer  "scope_id",   limit: 4
    t.boolean  "finished",   limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "startdate"
    t.date     "enddate"
  end

  add_index "contests", ["enddate"], name: "index_contests_on_enddate", using: :btree
  add_index "contests", ["finished"], name: "index_contests_on_finished", using: :btree
  add_index "contests", ["scope_id"], name: "index_contests_on_scope_id", using: :btree
  add_index "contests", ["slug"], name: "index_contests_on_slug", using: :btree
  add_index "contests", ["startdate"], name: "index_contests_on_startdate", using: :btree

  create_table "entries", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.text     "url",              limit: 65535
    t.date     "published"
    t.string   "author",           limit: 255
    t.string   "entry_identifier", limit: 255
    t.text     "summary",          limit: 65535
    t.binary   "content",          limit: 16777215
    t.integer  "scope_id",         limit: 4
    t.integer  "user_id",          limit: 4
    t.integer  "feed_id",          limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "image",            limit: 255
  end

  add_index "entries", ["feed_id"], name: "index_entries_on_feed_id", using: :btree
  add_index "entries", ["published"], name: "index_entries_on_published", using: :btree
  add_index "entries", ["scope_id"], name: "index_entries_on_scope_id", using: :btree
  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "fashion_fly_editor_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "slug",        limit: 255
    t.integer  "parent_id",   limit: 4
    t.string   "parent_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "scope_id",    limit: 4
  end

  add_index "fashion_fly_editor_categories", ["parent_id", "parent_type"], name: "category_parent", using: :btree
  add_index "fashion_fly_editor_categories", ["scope_id"], name: "index_fashion_fly_editor_categories_on_scope_id", using: :btree
  add_index "fashion_fly_editor_categories", ["slug"], name: "index_fashion_fly_editor_categories_on_slug", unique: true, using: :btree

  create_table "fashion_fly_editor_collection_items", force: :cascade do |t|
    t.integer  "collection_id", limit: 4
    t.integer  "item_id",       limit: 4
    t.integer  "position_x",    limit: 4
    t.integer  "position_y",    limit: 4
    t.float    "width",         limit: 24
    t.float    "height",        limit: 24
    t.float    "rotation",      limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image",         limit: 255
    t.integer  "scale_x",       limit: 4
    t.integer  "scale_y",       limit: 4
    t.integer  "order",         limit: 4,   default: 0
  end

  create_table "fashion_fly_editor_collections", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.text     "description",     limit: 65535
    t.string   "image",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id",     limit: 4
    t.integer  "user_id",         limit: 4
    t.integer  "actual_trend",    limit: 4
    t.integer  "last_trend",      limit: 4
    t.integer  "favorites_count", limit: 4
    t.boolean  "published",       limit: 1,     default: false
    t.integer  "visits_count",    limit: 4,     default: 0
    t.integer  "height",          limit: 4
    t.integer  "width",           limit: 4
  end

  add_index "fashion_fly_editor_collections", ["actual_trend"], name: "index_fashion_fly_editor_collections_on_actual_trend", using: :btree
  add_index "fashion_fly_editor_collections", ["category_id"], name: "index_fashion_fly_editor_collections_on_category_id", using: :btree
  add_index "fashion_fly_editor_collections", ["favorites_count"], name: "index_fashion_fly_editor_collections_on_favorites_count", using: :btree
  add_index "fashion_fly_editor_collections", ["published"], name: "index_fashion_fly_editor_collections_on_published", using: :btree
  add_index "fashion_fly_editor_collections", ["user_id"], name: "index_fashion_fly_editor_collections_on_user_id", using: :btree

  create_table "fashion_fly_editor_subscriptions", force: :cascade do |t|
    t.integer  "collection_id",   limit: 4
    t.integer  "subscriber_id",   limit: 4
    t.string   "subscriber_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fashion_fly_editor_subscriptions", ["collection_id"], name: "index_fashion_fly_editor_subscriptions_on_collection_id", using: :btree
  add_index "fashion_fly_editor_subscriptions", ["subscriber_id", "subscriber_type"], name: "subscriber", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "markable_id",   limit: 4
    t.string   "markable_type", limit: 255
    t.integer  "user_id",       limit: 4
    t.string   "cookie_store",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["cookie_store"], name: "index_favorites_on_cookie_store", length: {"cookie_store"=>30}, using: :btree
  add_index "favorites", ["created_at"], name: "index_favorites_on_created_at", using: :btree
  add_index "favorites", ["markable_id", "markable_type"], name: "index_favorites_on_markable_id_and_markable_type", using: :btree
  add_index "favorites", ["markable_id"], name: "index_favorites_on_markable_id", using: :btree
  add_index "favorites", ["markable_type"], name: "index_favorites_on_markable_type", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "feeds", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.binary   "value",      limit: 16777215
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "feeds", ["user_id"], name: "index_feeds_on_user_id", using: :btree

  create_table "icons", force: :cascade do |t|
    t.string "name",  limit: 255
    t.string "image", limit: 255
  end

  add_index "icons", ["name"], name: "index_icons_on_name", using: :btree

  create_table "lit_incomming_localizations", force: :cascade do |t|
    t.text     "translated_value",     limit: 65535
    t.integer  "locale_id",            limit: 4
    t.integer  "localization_key_id",  limit: 4
    t.integer  "localization_id",      limit: 4
    t.string   "locale_str",           limit: 255
    t.string   "localization_key_str", limit: 255
    t.integer  "source_id",            limit: 4
    t.integer  "incomming_id",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lit_incomming_localizations", ["incomming_id"], name: "index_lit_incomming_localizations_on_incomming_id", using: :btree
  add_index "lit_incomming_localizations", ["locale_id"], name: "index_lit_incomming_localizations_on_locale_id", using: :btree
  add_index "lit_incomming_localizations", ["localization_id"], name: "index_lit_incomming_localizations_on_localization_id", using: :btree
  add_index "lit_incomming_localizations", ["localization_key_id"], name: "index_lit_incomming_localizations_on_localization_key_id", using: :btree
  add_index "lit_incomming_localizations", ["source_id"], name: "index_lit_incomming_localizations_on_source_id", using: :btree

  create_table "lit_locales", force: :cascade do |t|
    t.string   "locale",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_hidden",  limit: 1,   default: false
  end

  create_table "lit_localization_keys", force: :cascade do |t|
    t.string   "localization_key", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_completed",     limit: 1,   default: false
    t.boolean  "is_starred",       limit: 1,   default: false
  end

  add_index "lit_localization_keys", ["localization_key"], name: "index_lit_localization_keys_on_localization_key", unique: true, using: :btree

  create_table "lit_localization_versions", force: :cascade do |t|
    t.text     "translated_value", limit: 65535
    t.integer  "localization_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lit_localization_versions", ["localization_id"], name: "index_lit_localization_versions_on_localization_id", using: :btree

  create_table "lit_localizations", force: :cascade do |t|
    t.integer  "locale_id",           limit: 4
    t.integer  "localization_key_id", limit: 4
    t.text     "default_value",       limit: 65535
    t.text     "translated_value",    limit: 65535
    t.boolean  "is_changed",          limit: 1,     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lit_localizations", ["locale_id"], name: "index_lit_localizations_on_locale_id", using: :btree
  add_index "lit_localizations", ["localization_key_id"], name: "index_lit_localizations_on_localization_key_id", using: :btree

  create_table "lit_sources", force: :cascade do |t|
    t.string   "identifier",      limit: 255
    t.string   "url",             limit: 255
    t.string   "api_key",         limit: 255
    t.datetime "last_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mappings", force: :cascade do |t|
    t.integer  "category_id",  limit: 4
    t.string   "name",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "affiliate_id", limit: 4
  end

  add_index "mappings", ["affiliate_id"], name: "index_mappings_on_affiliate_id", using: :btree
  add_index "mappings", ["category_id"], name: "index_mappings_on_category_id", using: :btree
  add_index "mappings", ["name"], name: "index_mappings_on_name", using: :btree

  create_table "overall_averages", force: :cascade do |t|
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "overall_avg",   limit: 24,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "title",      limit: 255
    t.text     "body",       limit: 65535
    t.integer  "scope_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["name", "scope_id"], name: "index_pages_on_name_and_scope_id", unique: true, using: :btree
  add_index "pages", ["name"], name: "index_pages_on_name", using: :btree
  add_index "pages", ["scope_id"], name: "index_pages_on_scope_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "affi_code",            limit: 255
    t.string   "name",                 limit: 255
    t.string   "number",               limit: 255
    t.text     "description",          limit: 65535
    t.integer  "brand_id",             limit: 4
    t.integer  "colorization_id",      limit: 4
    t.string   "ean",                  limit: 255
    t.decimal  "price",                              precision: 10, scale: 2
    t.string   "shippingHandlingCost", limit: 255
    t.string   "lastModified",         limit: 255
    t.string   "image",                limit: 255
    t.string   "original",             limit: 255
    t.string   "deliveryTime",         limit: 255
    t.string   "currencyCode",         limit: 255
    t.text     "deepLink",             limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "scope_id",             limit: 4
    t.boolean  "published",            limit: 1,                              default: false
    t.integer  "actual_trend",         limit: 4,                              default: 0
    t.integer  "last_trend",           limit: 4,                              default: 0
    t.integer  "favorites_count",      limit: 4,                              default: 0
    t.integer  "affiliate_id",         limit: 4
    t.boolean  "premium",              limit: 1,                              default: false
    t.integer  "width",                limit: 4,                              default: 0
    t.integer  "height",               limit: 4,                              default: 0
    t.integer  "random_order",         limit: 4,                              default: 0
    t.decimal  "sale_price",                         precision: 10, scale: 2
    t.boolean  "sale",                 limit: 1,                              default: false
    t.boolean  "dirty",                limit: 1,                              default: false
    t.integer  "visits_count",         limit: 4,                              default: 0
  end

  add_index "products", ["actual_trend"], name: "index_products_on_actual_trend", using: :btree
  add_index "products", ["affiliate_id", "affi_code", "scope_id"], name: "index_products_on_affiliate_id_and_affi_code_and_scope_id", unique: true, using: :btree
  add_index "products", ["affiliate_id"], name: "index_products_on_affiliate_id", using: :btree
  add_index "products", ["brand_id"], name: "index_products_on_brand_id", using: :btree
  add_index "products", ["colorization_id"], name: "index_products_on_colorization_id", using: :btree
  add_index "products", ["dirty"], name: "index_products_on_dirty", using: :btree
  add_index "products", ["favorites_count"], name: "index_products_on_favorites_count", using: :btree
  add_index "products", ["premium"], name: "index_products_on_premium", using: :btree
  add_index "products", ["published"], name: "index_products_on_published", using: :btree
  add_index "products", ["random_order"], name: "index_products_on_random_order", using: :btree
  add_index "products", ["sale"], name: "index_products_on_sale", using: :btree
  add_index "products", ["scope_id"], name: "index_products_on_scope_id", using: :btree

  create_table "properties", force: :cascade do |t|
    t.integer  "scope_id",                   limit: 4
    t.string   "shop_highlight_title",       limit: 255
    t.string   "shop_highlight_image",       limit: 255
    t.text     "shop_highlight_link",        limit: 65535
    t.string   "collection_highlight_title", limit: 255
    t.string   "collection_highlight_image", limit: 255
    t.text     "collection_highlight_link",  limit: 65535
    t.string   "category_highlight_title",   limit: 255
    t.string   "category_highlight_image",   limit: 255
    t.text     "category_highlight_link",    limit: 65535
    t.boolean  "show_new_startpage",         limit: 1
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "properties", ["scope_id"], name: "index_properties_on_scope_id", unique: true, using: :btree

  create_table "rates", force: :cascade do |t|
    t.integer  "rater_id",      limit: 4
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "stars",         limit: 24,  null: false
    t.string   "dimension",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: :cascade do |t|
    t.integer  "cacheable_id",   limit: 4
    t.string   "cacheable_type", limit: 255
    t.float    "avg",            limit: 24,  null: false
    t.integer  "qty",            limit: 4,   null: false
    t.string   "dimension",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "rebuilders", force: :cascade do |t|
    t.integer "collection_id", limit: 4, null: false
  end

  add_index "rebuilders", ["collection_id"], name: "index_rebuilders_on_collection_id", unique: true, using: :btree

  create_table "s_addon_premiums", force: :cascade do |t|
    t.float   "startprice",         limit: 53, default: 0.0, null: false
    t.string  "ordernumber",        limit: 30, default: "0", null: false
    t.string  "ordernumber_export", limit: 30,               null: false
    t.integer "subshopID",          limit: 4,                null: false
  end

  create_table "s_article_configurator_dependencies", force: :cascade do |t|
    t.integer "configurator_set_id", limit: 4, null: false
    t.integer "parent_id",           limit: 4
    t.integer "child_id",            limit: 4
  end

  add_index "s_article_configurator_dependencies", ["configurator_set_id"], name: "configurator_set_id", using: :btree

  create_table "s_article_configurator_groups", force: :cascade do |t|
    t.string  "name",        limit: 255,   null: false
    t.text    "description", limit: 65535
    t.integer "position",    limit: 4,     null: false
  end

  create_table "s_article_configurator_option_relations", force: :cascade do |t|
    t.integer "article_id", limit: 4, null: false
    t.integer "option_id",  limit: 4, null: false
  end

  add_index "s_article_configurator_option_relations", ["article_id", "option_id"], name: "article_id", unique: true, using: :btree

  create_table "s_article_configurator_options", force: :cascade do |t|
    t.integer "group_id", limit: 4
    t.string  "name",     limit: 255, null: false
    t.integer "position", limit: 4,   null: false
  end

  add_index "s_article_configurator_options", ["group_id", "name"], name: "group_id", unique: true, using: :btree

  create_table "s_article_configurator_price_surcharges", force: :cascade do |t|
    t.integer "configurator_set_id", limit: 4,                          null: false
    t.integer "parent_id",           limit: 4
    t.integer "child_id",            limit: 4
    t.decimal "surcharge",                     precision: 10, scale: 3, null: false
  end

  add_index "s_article_configurator_price_surcharges", ["configurator_set_id"], name: "configurator_set_id", using: :btree

  create_table "s_article_configurator_set_group_relations", id: false, force: :cascade do |t|
    t.integer "set_id",   limit: 4, default: 0, null: false
    t.integer "group_id", limit: 4, default: 0, null: false
  end

  create_table "s_article_configurator_set_option_relations", id: false, force: :cascade do |t|
    t.integer "set_id",    limit: 4, default: 0, null: false
    t.integer "option_id", limit: 4, default: 0, null: false
  end

  create_table "s_article_configurator_sets", force: :cascade do |t|
    t.string  "name",   limit: 255,             null: false
    t.boolean "public", limit: 1,               null: false
    t.integer "type",   limit: 4,   default: 0, null: false
  end

  add_index "s_article_configurator_sets", ["name"], name: "name", using: :btree

  create_table "s_article_configurator_template_prices", force: :cascade do |t|
    t.integer "template_id",        limit: 4
    t.string  "customer_group_key", limit: 30,                                        null: false
    t.integer "from",               limit: 4,                                         null: false
    t.string  "to",                 limit: 30,                                        null: false
    t.float   "price",              limit: 53,                          default: 0.0, null: false
    t.float   "pseudoprice",        limit: 53
    t.float   "baseprice",          limit: 53
    t.decimal "percent",                       precision: 10, scale: 2
  end

  add_index "s_article_configurator_template_prices", ["customer_group_key", "from"], name: "pricegroup_2", using: :btree
  add_index "s_article_configurator_template_prices", ["customer_group_key", "to"], name: "pricegroup", using: :btree
  add_index "s_article_configurator_template_prices", ["template_id"], name: "template_id", using: :btree

  create_table "s_article_configurator_template_prices_attributes", force: :cascade do |t|
    t.integer "template_price_id", limit: 4
  end

  add_index "s_article_configurator_template_prices_attributes", ["template_price_id"], name: "priceID", unique: true, using: :btree

  create_table "s_article_configurator_templates", force: :cascade do |t|
    t.integer "article_id",     limit: 4,                            default: 0, null: false
    t.string  "order_number",   limit: 40,                                       null: false
    t.string  "suppliernumber", limit: 255
    t.string  "additionaltext", limit: 255
    t.integer "impressions",    limit: 4,                            default: 0, null: false
    t.integer "sales",          limit: 4,                            default: 0, null: false
    t.integer "active",         limit: 4,                            default: 0, null: false
    t.integer "instock",        limit: 4
    t.integer "stockmin",       limit: 4
    t.decimal "weight",                     precision: 10, scale: 3
    t.integer "position",       limit: 4,                                        null: false
    t.decimal "width",                      precision: 10, scale: 3
    t.decimal "height",                     precision: 10, scale: 3
    t.decimal "length",                     precision: 10, scale: 3
    t.string  "ean",            limit: 255
    t.integer "unit_id",        limit: 4
    t.integer "purchasesteps",  limit: 4
    t.integer "maxpurchase",    limit: 4
    t.integer "minpurchase",    limit: 4
    t.decimal "purchaseunit",               precision: 11, scale: 4
    t.decimal "referenceunit",              precision: 10, scale: 3
    t.string  "packunit",       limit: 255
    t.date    "releasedate"
    t.integer "shippingfree",   limit: 4,                            default: 0, null: false
    t.string  "shippingtime",   limit: 11
  end

  add_index "s_article_configurator_templates", ["article_id"], name: "articleID", using: :btree

  create_table "s_article_configurator_templates_attributes", force: :cascade do |t|
    t.integer "template_id", limit: 4
    t.string  "attr1",       limit: 255,      default: "0"
    t.string  "attr2",       limit: 255,      default: "0"
    t.string  "attr3",       limit: 255,      default: "0"
    t.string  "attr4",       limit: 255
    t.string  "attr5",       limit: 255
    t.string  "attr6",       limit: 255
    t.string  "attr7",       limit: 255
    t.string  "attr8",       limit: 255,      default: "0"
    t.text    "attr9",       limit: 16777215
    t.text    "attr10",      limit: 16777215
    t.string  "attr11",      limit: 200
    t.string  "attr12",      limit: 200
    t.string  "attr13",      limit: 255,      default: "0"
    t.string  "attr14",      limit: 200
    t.string  "attr15",      limit: 30
    t.string  "attr16",      limit: 30
    t.date    "attr17"
    t.text    "attr18",      limit: 16777215
    t.string  "attr19",      limit: 255
    t.string  "attr20",      limit: 20
  end

  add_index "s_article_configurator_templates_attributes", ["template_id"], name: "templateID", using: :btree

  create_table "s_article_img_mapping_rules", force: :cascade do |t|
    t.integer "mapping_id", limit: 4, null: false
    t.integer "option_id",  limit: 4, null: false
  end

  create_table "s_article_img_mappings", force: :cascade do |t|
    t.integer "image_id", limit: 4, null: false
  end

  add_index "s_article_img_mappings", ["image_id"], name: "image_id", using: :btree

  create_table "s_articles", force: :cascade do |t|
    t.integer  "supplierID",          limit: 4
    t.string   "name",                limit: 100,                  null: false
    t.text     "description",         limit: 16777215
    t.text     "description_long",    limit: 16777215
    t.string   "shippingtime",        limit: 11
    t.date     "datum"
    t.integer  "active",              limit: 4,        default: 0, null: false
    t.integer  "taxID",               limit: 4
    t.integer  "pseudosales",         limit: 4,        default: 0, null: false
    t.integer  "topseller",           limit: 4,        default: 0, null: false
    t.string   "metaTitle",           limit: 255
    t.string   "keywords",            limit: 255
    t.datetime "changetime",                                       null: false
    t.integer  "pricegroupID",        limit: 4
    t.integer  "pricegroupActive",    limit: 4,                    null: false
    t.integer  "filtergroupID",       limit: 4
    t.integer  "laststock",           limit: 4,                    null: false
    t.integer  "crossbundlelook",     limit: 4,                    null: false
    t.integer  "notification",        limit: 4,                    null: false
    t.string   "template",            limit: 255,                  null: false
    t.integer  "mode",                limit: 4,                    null: false
    t.integer  "main_detail_id",      limit: 4
    t.datetime "available_from"
    t.datetime "available_to"
    t.integer  "configurator_set_id", limit: 4
  end

  add_index "s_articles", ["active", "datum"], name: "product_newcomer", using: :btree
  add_index "s_articles", ["active", "filtergroupID"], name: "get_category_filters", using: :btree
  add_index "s_articles", ["changetime"], name: "changetime", using: :btree
  add_index "s_articles", ["configurator_set_id"], name: "configurator_set_id", using: :btree
  add_index "s_articles", ["datum", "id"], name: "articles_by_category_sort_release", using: :btree
  add_index "s_articles", ["datum"], name: "datum", using: :btree
  add_index "s_articles", ["main_detail_id"], name: "main_detailID", unique: true, using: :btree
  add_index "s_articles", ["name", "id"], name: "articles_by_category_sort_name", using: :btree
  add_index "s_articles", ["name"], name: "name", using: :btree
  add_index "s_articles", ["shippingtime"], name: "shippingtime", using: :btree
  add_index "s_articles", ["supplierID"], name: "supplierID", using: :btree

  create_table "s_articles_also_bought_ro", force: :cascade do |t|
    t.integer "article_id",         limit: 4,             null: false
    t.integer "related_article_id", limit: 4,             null: false
    t.integer "sales",              limit: 4, default: 0, null: false
  end

  add_index "s_articles_also_bought_ro", ["article_id", "related_article_id"], name: "bought_combination", unique: true, using: :btree
  add_index "s_articles_also_bought_ro", ["article_id", "sales", "related_article_id"], name: "get_also_bought_articles", using: :btree
  add_index "s_articles_also_bought_ro", ["article_id"], name: "article_id", using: :btree
  add_index "s_articles_also_bought_ro", ["related_article_id"], name: "related_article_id", using: :btree

  create_table "s_articles_attributes", force: :cascade do |t|
    t.integer "articleID",                     limit: 4
    t.integer "articledetailsID",              limit: 4
    t.string  "attr1",                         limit: 255,                               default: "0"
    t.string  "attr2",                         limit: 255,                               default: "0"
    t.string  "attr3",                         limit: 255,                               default: "0"
    t.string  "attr4",                         limit: 255
    t.text    "attr5",                         limit: 65535
    t.string  "attr6",                         limit: 255
    t.string  "attr7",                         limit: 255
    t.string  "attr8",                         limit: 255,                               default: "0"
    t.string  "attr9",                         limit: 255,                               default: ""
    t.string  "attr10",                        limit: 255,                               default: ""
    t.string  "attr11",                        limit: 255
    t.string  "attr12",                        limit: 255
    t.string  "attr13",                        limit: 255,                               default: "0"
    t.string  "attr14",                        limit: 200
    t.string  "attr15",                        limit: 30
    t.string  "attr16",                        limit: 30
    t.date    "attr17"
    t.text    "attr18",                        limit: 16777215
    t.string  "attr19",                        limit: 255
    t.string  "attr20",                        limit: 20
    t.decimal "swp_refundsystem_refund_price",                  precision: 15, scale: 4
    t.string  "swp_refundsystem_refund_type",  limit: 6
    t.boolean "swag_is_trusted_shops_article", limit: 1,                                 default: false
  end

  add_index "s_articles_attributes", ["articleID"], name: "articleID", using: :btree
  add_index "s_articles_attributes", ["articledetailsID"], name: "articledetailsID", unique: true, using: :btree

  create_table "s_articles_avoid_customergroups", id: false, force: :cascade do |t|
    t.integer "articleID",       limit: 4, null: false
    t.integer "customergroupID", limit: 4, null: false
  end

  add_index "s_articles_avoid_customergroups", ["articleID", "customergroupID"], name: "articleID", unique: true, using: :btree

  create_table "s_articles_categories", force: :cascade do |t|
    t.integer "articleID",  limit: 4, null: false
    t.integer "categoryID", limit: 4, null: false
  end

  add_index "s_articles_categories", ["articleID", "categoryID"], name: "articleID", unique: true, using: :btree
  add_index "s_articles_categories", ["articleID"], name: "articleID_2", using: :btree
  add_index "s_articles_categories", ["categoryID"], name: "categoryID", using: :btree

  create_table "s_articles_categories_ro", force: :cascade do |t|
    t.integer "articleID",        limit: 4, null: false
    t.integer "categoryID",       limit: 4, null: false
    t.integer "parentCategoryID", limit: 4, null: false
  end

  add_index "s_articles_categories_ro", ["articleID", "categoryID", "parentCategoryID"], name: "articleID", unique: true, using: :btree
  add_index "s_articles_categories_ro", ["articleID", "id"], name: "category_id_by_article_id", using: :btree
  add_index "s_articles_categories_ro", ["articleID"], name: "articleID_2", using: :btree
  add_index "s_articles_categories_ro", ["categoryID", "parentCategoryID"], name: "categoryID_2", using: :btree
  add_index "s_articles_categories_ro", ["categoryID"], name: "categoryID", using: :btree

  create_table "s_articles_categories_seo", force: :cascade do |t|
    t.integer "shop_id",     limit: 4, null: false
    t.integer "article_id",  limit: 4, null: false
    t.integer "category_id", limit: 4, null: false
  end

  add_index "s_articles_categories_seo", ["shop_id", "article_id"], name: "shop_article", using: :btree

  create_table "s_articles_details", force: :cascade do |t|
    t.integer "articleID",      limit: 4,                            default: 0, null: false
    t.string  "ordernumber",    limit: 40,                                       null: false
    t.string  "suppliernumber", limit: 255
    t.integer "kind",           limit: 4,                            default: 0, null: false
    t.string  "additionaltext", limit: 255
    t.integer "impressions",    limit: 4,                            default: 0, null: false
    t.integer "sales",          limit: 4,                            default: 0, null: false
    t.integer "active",         limit: 4,                            default: 0, null: false
    t.integer "instock",        limit: 4
    t.integer "stockmin",       limit: 4
    t.decimal "weight",                     precision: 10, scale: 3
    t.integer "position",       limit: 4,                                        null: false
    t.decimal "width",                      precision: 10, scale: 3
    t.decimal "height",                     precision: 10, scale: 3
    t.decimal "length",                     precision: 10, scale: 3
    t.string  "ean",            limit: 255
    t.integer "unitID",         limit: 4
    t.integer "purchasesteps",  limit: 4
    t.integer "maxpurchase",    limit: 4
    t.integer "minpurchase",    limit: 4
    t.decimal "purchaseunit",               precision: 11, scale: 4
    t.decimal "referenceunit",              precision: 10, scale: 3
    t.string  "packunit",       limit: 255
    t.date    "releasedate"
    t.integer "shippingfree",   limit: 4,                            default: 0, null: false
    t.string  "shippingtime",   limit: 11
  end

  add_index "s_articles_details", ["articleID"], name: "articleID", using: :btree
  add_index "s_articles_details", ["kind", "sales"], name: "get_similar_articles", using: :btree
  add_index "s_articles_details", ["ordernumber"], name: "ordernumber", unique: true, using: :btree
  add_index "s_articles_details", ["releasedate"], name: "releasedate", using: :btree
  add_index "s_articles_details", ["sales", "impressions", "articleID"], name: "articles_by_category_sort_popularity", using: :btree

  create_table "s_articles_downloads", force: :cascade do |t|
    t.integer "articleID",   limit: 4,   null: false
    t.string  "description", limit: 255, null: false
    t.string  "filename",    limit: 255, null: false
    t.float   "size",        limit: 53,  null: false
  end

  add_index "s_articles_downloads", ["articleID"], name: "articleID", using: :btree

  create_table "s_articles_downloads_attributes", force: :cascade do |t|
    t.integer "downloadID", limit: 4
  end

  add_index "s_articles_downloads_attributes", ["downloadID"], name: "downloadID", unique: true, using: :btree

  create_table "s_articles_esd", force: :cascade do |t|
    t.integer  "articleID",        limit: 4,   default: 0, null: false
    t.integer  "articledetailsID", limit: 4,   default: 0, null: false
    t.string   "file",             limit: 255,             null: false
    t.integer  "serials",          limit: 4,   default: 0, null: false
    t.integer  "notification",     limit: 4,   default: 0, null: false
    t.integer  "maxdownloads",     limit: 4,   default: 0, null: false
    t.datetime "datum",                                    null: false
  end

  add_index "s_articles_esd", ["articleID"], name: "articleID", using: :btree
  add_index "s_articles_esd", ["articledetailsID"], name: "articledetailsID", using: :btree

  create_table "s_articles_esd_attributes", force: :cascade do |t|
    t.integer "esdID", limit: 4
  end

  add_index "s_articles_esd_attributes", ["esdID"], name: "esdID", unique: true, using: :btree

  create_table "s_articles_esd_serials", force: :cascade do |t|
    t.string  "serialnumber", limit: 255,             null: false
    t.integer "esdID",        limit: 4,   default: 0, null: false
  end

  add_index "s_articles_esd_serials", ["esdID"], name: "esdID", using: :btree

  create_table "s_articles_img", force: :cascade do |t|
    t.integer "articleID",         limit: 4
    t.string  "img",               limit: 100
    t.integer "main",              limit: 4,        null: false
    t.string  "description",       limit: 255,      null: false
    t.integer "position",          limit: 4,        null: false
    t.integer "width",             limit: 4,        null: false
    t.integer "height",            limit: 4,        null: false
    t.text    "relations",         limit: 16777215, null: false
    t.string  "extension",         limit: 255,      null: false
    t.integer "parent_id",         limit: 4
    t.integer "article_detail_id", limit: 4
    t.integer "media_id",          limit: 4
  end

  add_index "s_articles_img", ["articleID", "main", "position"], name: "article_cover_image_query", using: :btree
  add_index "s_articles_img", ["articleID", "position"], name: "article_images_query", using: :btree
  add_index "s_articles_img", ["articleID"], name: "artikel_id", using: :btree
  add_index "s_articles_img", ["article_detail_id"], name: "article_detail_id", using: :btree
  add_index "s_articles_img", ["media_id"], name: "media_id", using: :btree
  add_index "s_articles_img", ["parent_id"], name: "parent_id", using: :btree

  create_table "s_articles_img_attributes", force: :cascade do |t|
    t.integer "imageID",    limit: 4
    t.string  "attribute1", limit: 255
    t.string  "attribute2", limit: 255
    t.string  "attribute3", limit: 255
  end

  add_index "s_articles_img_attributes", ["imageID"], name: "imageID", unique: true, using: :btree

  create_table "s_articles_information", force: :cascade do |t|
    t.integer "articleID",   limit: 4,   default: 0, null: false
    t.string  "description", limit: 255,             null: false
    t.string  "link",        limit: 255,             null: false
    t.string  "target",      limit: 30,              null: false
  end

  add_index "s_articles_information", ["articleID"], name: "hauptid", using: :btree

  create_table "s_articles_information_attributes", force: :cascade do |t|
    t.integer "informationID", limit: 4
  end

  add_index "s_articles_information_attributes", ["informationID"], name: "informationID", unique: true, using: :btree

  create_table "s_articles_notification", force: :cascade do |t|
    t.string   "ordernumber", limit: 255, null: false
    t.datetime "date",                    null: false
    t.string   "mail",        limit: 255, null: false
    t.integer  "send",        limit: 4,   null: false
    t.string   "language",    limit: 255, null: false
    t.string   "shopLink",    limit: 255, null: false
  end

  create_table "s_articles_prices", force: :cascade do |t|
    t.string  "pricegroup",       limit: 30,                                        null: false
    t.integer "from",             limit: 4,                                         null: false
    t.string  "to",               limit: 30,                                        null: false
    t.integer "articleID",        limit: 4,                           default: 0,   null: false
    t.integer "articledetailsID", limit: 4,                           default: 0,   null: false
    t.float   "price",            limit: 53,                          default: 0.0, null: false
    t.float   "pseudoprice",      limit: 53
    t.float   "baseprice",        limit: 53
    t.decimal "percent",                     precision: 10, scale: 2
  end

  add_index "s_articles_prices", ["articleID"], name: "articleID", using: :btree
  add_index "s_articles_prices", ["articledetailsID"], name: "articledetailsID", using: :btree
  add_index "s_articles_prices", ["pricegroup", "from", "articledetailsID"], name: "pricegroup_2", using: :btree
  add_index "s_articles_prices", ["pricegroup", "to", "articledetailsID"], name: "pricegroup", using: :btree

  create_table "s_articles_prices_attributes", force: :cascade do |t|
    t.integer "priceID", limit: 4
  end

  add_index "s_articles_prices_attributes", ["priceID"], name: "priceID", unique: true, using: :btree

  create_table "s_articles_relationships", force: :cascade do |t|
    t.integer "articleID",      limit: 4,  null: false
    t.string  "relatedarticle", limit: 30, null: false
  end

  add_index "s_articles_relationships", ["articleID", "relatedarticle"], name: "articleID", unique: true, using: :btree

  create_table "s_articles_similar", force: :cascade do |t|
    t.integer "articleID",      limit: 4,   null: false
    t.string  "relatedarticle", limit: 255, null: false
  end

  add_index "s_articles_similar", ["articleID", "relatedarticle"], name: "articleID", unique: true, using: :btree

  create_table "s_articles_similar_shown_ro", force: :cascade do |t|
    t.integer  "article_id",         limit: 4,             null: false
    t.integer  "related_article_id", limit: 4,             null: false
    t.integer  "viewed",             limit: 4, default: 0, null: false
    t.datetime "init_date",                                null: false
  end

  add_index "s_articles_similar_shown_ro", ["article_id", "related_article_id"], name: "viewed_combination", unique: true, using: :btree
  add_index "s_articles_similar_shown_ro", ["viewed", "related_article_id", "article_id"], name: "viewed", using: :btree

  create_table "s_articles_supplier", force: :cascade do |t|
    t.string "name",             limit: 100,        null: false
    t.string "img",              limit: 100,        null: false
    t.string "link",             limit: 100,        null: false
    t.text   "description",      limit: 4294967295
    t.string "meta_title",       limit: 255
    t.string "meta_description", limit: 255
    t.string "meta_keywords",    limit: 255
  end

  create_table "s_articles_supplier_attributes", force: :cascade do |t|
    t.integer "supplierID", limit: 4
  end

  add_index "s_articles_supplier_attributes", ["supplierID"], name: "supplierID", unique: true, using: :btree

  create_table "s_articles_top_seller_ro", force: :cascade do |t|
    t.integer  "article_id",   limit: 4,             null: false
    t.integer  "sales",        limit: 4, default: 0, null: false
    t.datetime "last_cleared"
  end

  add_index "s_articles_top_seller_ro", ["article_id"], name: "article_id", unique: true, using: :btree
  add_index "s_articles_top_seller_ro", ["sales", "article_id"], name: "listing_query", using: :btree
  add_index "s_articles_top_seller_ro", ["sales"], name: "sales", using: :btree

  create_table "s_articles_translations", force: :cascade do |t|
    t.integer "articleID",         limit: 4,        null: false
    t.integer "languageID",        limit: 4,        null: false
    t.string  "name",              limit: 255,      null: false
    t.text    "keywords",          limit: 16777215, null: false
    t.text    "description",       limit: 16777215, null: false
    t.text    "description_long",  limit: 16777215, null: false
    t.text    "description_clear", limit: 16777215, null: false
    t.string  "attr1",             limit: 255,      null: false
    t.string  "attr2",             limit: 255,      null: false
    t.string  "attr3",             limit: 255,      null: false
    t.string  "attr4",             limit: 255,      null: false
    t.string  "attr5",             limit: 255,      null: false
  end

  add_index "s_articles_translations", ["articleID", "languageID"], name: "articleID", unique: true, using: :btree

  create_table "s_articles_vote", force: :cascade do |t|
    t.integer  "articleID",   limit: 4,        null: false
    t.string   "name",        limit: 255,      null: false
    t.string   "headline",    limit: 255,      null: false
    t.text     "comment",     limit: 16777215, null: false
    t.float    "points",      limit: 53,       null: false
    t.datetime "datum",                        null: false
    t.integer  "active",      limit: 4,        null: false
    t.string   "email",       limit: 255,      null: false
    t.text     "answer",      limit: 65535,    null: false
    t.datetime "answer_date",                  null: false
  end

  add_index "s_articles_vote", ["articleID", "active", "datum"], name: "get_articles_votes", using: :btree
  add_index "s_articles_vote", ["articleID"], name: "articleID", using: :btree

  create_table "s_billing_template", primary_key: "ID", force: :cascade do |t|
    t.string  "name",     limit: 255,                  null: false
    t.text    "value",    limit: 16777215,             null: false
    t.integer "typ",      limit: 3,                    null: false
    t.string  "group",    limit: 255,                  null: false
    t.string  "desc",     limit: 255,                  null: false
    t.integer "position", limit: 4,                    null: false
    t.integer "show",     limit: 4,        default: 1, null: false
  end

  create_table "s_blog", force: :cascade do |t|
    t.string   "title",             limit: 255,      null: false
    t.integer  "author_id",         limit: 4
    t.integer  "active",            limit: 4,        null: false
    t.text     "short_description", limit: 65535,    null: false
    t.text     "description",       limit: 16777215, null: false
    t.integer  "views",             limit: 4
    t.datetime "display_date",                       null: false
    t.integer  "category_id",       limit: 4
    t.string   "template",          limit: 255,      null: false
    t.string   "meta_keywords",     limit: 255
    t.string   "meta_description",  limit: 150
    t.string   "meta_title",        limit: 255
  end

  add_index "s_blog", ["display_date"], name: "emotion_get_blog_entry", using: :btree

  create_table "s_blog_assigned_articles", force: :cascade do |t|
    t.integer "blog_id",    limit: 4, null: false
    t.integer "article_id", limit: 4, null: false
  end

  add_index "s_blog_assigned_articles", ["blog_id"], name: "blog_id", using: :btree

  create_table "s_blog_attributes", force: :cascade do |t|
    t.integer "blog_id",    limit: 4
    t.string  "attribute1", limit: 255
    t.string  "attribute2", limit: 255
    t.string  "attribute3", limit: 255
    t.string  "attribute4", limit: 255
    t.string  "attribute5", limit: 255
    t.string  "attribute6", limit: 255
  end

  add_index "s_blog_attributes", ["blog_id"], name: "blog_id", using: :btree

  create_table "s_blog_comments", force: :cascade do |t|
    t.integer  "blog_id",       limit: 4
    t.string   "name",          limit: 255,      null: false
    t.string   "headline",      limit: 255,      null: false
    t.text     "comment",       limit: 16777215, null: false
    t.datetime "creation_date",                  null: false
    t.integer  "active",        limit: 4,        null: false
    t.string   "email",         limit: 255,      null: false
    t.float    "points",        limit: 53,       null: false
  end

  create_table "s_blog_media", force: :cascade do |t|
    t.integer "blog_id",  limit: 4, null: false
    t.integer "media_id", limit: 4, null: false
    t.integer "preview",  limit: 4, null: false
  end

  add_index "s_blog_media", ["blog_id"], name: "blogID", using: :btree

  create_table "s_blog_tags", force: :cascade do |t|
    t.integer "blog_id", limit: 4
    t.string  "name",    limit: 255, null: false
  end

  add_index "s_blog_tags", ["blog_id"], name: "blogID", using: :btree

  create_table "s_campaigns_articles", force: :cascade do |t|
    t.integer "parentID",           limit: 4,   default: 0,   null: false
    t.string  "articleordernumber", limit: 30,  default: "0", null: false
    t.string  "name",               limit: 255,               null: false
    t.string  "type",               limit: 30,                null: false
    t.integer "position",           limit: 4,   default: 0,   null: false
  end

  create_table "s_campaigns_banner", force: :cascade do |t|
    t.integer "parentID",    limit: 4,   null: false
    t.string  "image",       limit: 255, null: false
    t.string  "link",        limit: 255, null: false
    t.string  "linkTarget",  limit: 255, null: false
    t.string  "description", limit: 255, null: false
  end

  create_table "s_campaigns_containers", force: :cascade do |t|
    t.integer "promotionID", limit: 4
    t.string  "value",       limit: 255,             null: false
    t.string  "type",        limit: 255,             null: false
    t.string  "description", limit: 255,             null: false
    t.integer "position",    limit: 4,   default: 0, null: false
  end

  create_table "s_campaigns_groups", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "s_campaigns_html", force: :cascade do |t|
    t.integer "parentID",  limit: 4
    t.string  "headline",  limit: 255,      null: false
    t.text    "html",      limit: 16777215, null: false
    t.string  "image",     limit: 255,      null: false
    t.string  "link",      limit: 255,      null: false
    t.string  "alignment", limit: 255,      null: false
  end

  create_table "s_campaigns_links", force: :cascade do |t|
    t.integer "parentID",    limit: 4,   default: 0, null: false
    t.string  "description", limit: 255,             null: false
    t.string  "link",        limit: 255,             null: false
    t.string  "target",      limit: 255,             null: false
    t.integer "position",    limit: 4,   default: 0, null: false
  end

  create_table "s_campaigns_logs", force: :cascade do |t|
    t.datetime "datum",                             null: false
    t.integer  "mailingID", limit: 4,   default: 0, null: false
    t.string   "email",     limit: 255,             null: false
    t.integer  "articleID", limit: 4,   default: 0, null: false
  end

  create_table "s_campaigns_mailaddresses", force: :cascade do |t|
    t.integer "customer",    limit: 4,  null: false
    t.integer "groupID",     limit: 4,  null: false
    t.string  "email",       limit: 90, null: false
    t.integer "lastmailing", limit: 4,  null: false
    t.integer "lastread",    limit: 4,  null: false
  end

  add_index "s_campaigns_mailaddresses", ["email"], name: "email", using: :btree
  add_index "s_campaigns_mailaddresses", ["groupID"], name: "groupID", using: :btree
  add_index "s_campaigns_mailaddresses", ["lastmailing"], name: "lastmailing", using: :btree
  add_index "s_campaigns_mailaddresses", ["lastread"], name: "lastread", using: :btree

  create_table "s_campaigns_maildata", force: :cascade do |t|
    t.string   "email",        limit: 255, null: false
    t.integer  "groupID",      limit: 4,   null: false
    t.string   "salutation",   limit: 255
    t.string   "title",        limit: 255
    t.string   "firstname",    limit: 255
    t.string   "lastname",     limit: 255
    t.string   "street",       limit: 255
    t.string   "streetnumber", limit: 255
    t.string   "zipcode",      limit: 255
    t.string   "city",         limit: 255
    t.datetime "added",                    null: false
    t.datetime "deleted"
  end

  add_index "s_campaigns_maildata", ["email", "groupID"], name: "email", unique: true, using: :btree

  create_table "s_campaigns_mailings", force: :cascade do |t|
    t.date     "datum"
    t.text     "groups",        limit: 16777215,             null: false
    t.string   "subject",       limit: 100,                  null: false
    t.string   "sendermail",    limit: 255,                  null: false
    t.string   "sendername",    limit: 255,                  null: false
    t.integer  "plaintext",     limit: 4,                    null: false
    t.integer  "templateID",    limit: 4,        default: 0, null: false
    t.integer  "languageID",    limit: 4,                    null: false
    t.integer  "status",        limit: 4,        default: 0, null: false
    t.datetime "locked"
    t.integer  "recipients",    limit: 4,                    null: false
    t.integer  "read",          limit: 4,        default: 0, null: false
    t.integer  "clicked",       limit: 4,        default: 0, null: false
    t.string   "customergroup", limit: 25,                   null: false
    t.integer  "publish",       limit: 4,                    null: false
  end

  create_table "s_campaigns_positions", force: :cascade do |t|
    t.integer "promotionID", limit: 4, default: 0, null: false
    t.integer "containerID", limit: 4, default: 0, null: false
    t.integer "position",    limit: 4, default: 0, null: false
  end

  create_table "s_campaigns_sender", force: :cascade do |t|
    t.string "email", limit: 255, null: false
    t.string "name",  limit: 255, null: false
  end

  create_table "s_campaigns_templates", force: :cascade do |t|
    t.string "path",        limit: 255, null: false
    t.string "description", limit: 255, null: false
  end

  create_table "s_categories", force: :cascade do |t|
    t.integer  "parent",           limit: 4
    t.string   "path",             limit: 255
    t.string   "description",      limit: 255,                  null: false
    t.integer  "position",         limit: 4,        default: 0
    t.integer  "left",             limit: 4,                    null: false
    t.integer  "right",            limit: 4,                    null: false
    t.integer  "level",            limit: 4,                    null: false
    t.datetime "added",                                         null: false
    t.datetime "changed",                                       null: false
    t.text     "metakeywords",     limit: 16777215
    t.text     "metadescription",  limit: 16777215
    t.string   "cmsheadline",      limit: 255
    t.text     "cmstext",          limit: 16777215
    t.string   "template",         limit: 255
    t.integer  "noviewselect",     limit: 4
    t.integer  "active",           limit: 4,                    null: false
    t.integer  "blog",             limit: 4,                    null: false
    t.integer  "showfiltergroups", limit: 4,                    null: false
    t.string   "external",         limit: 255
    t.integer  "hidefilter",       limit: 4,                    null: false
    t.integer  "hidetop",          limit: 4,                    null: false
    t.integer  "mediaID",          limit: 4
  end

  add_index "s_categories", ["description"], name: "description", using: :btree
  add_index "s_categories", ["left", "right"], name: "left", using: :btree
  add_index "s_categories", ["level"], name: "level", using: :btree
  add_index "s_categories", ["parent", "position", "id"], name: "active_query_builder", using: :btree
  add_index "s_categories", ["parent"], name: "parent", using: :btree
  add_index "s_categories", ["position"], name: "position", using: :btree

  create_table "s_categories_attributes", force: :cascade do |t|
    t.integer "categoryID", limit: 4
    t.string  "attribute1", limit: 255
    t.string  "attribute2", limit: 255
    t.string  "attribute3", limit: 255
    t.string  "attribute4", limit: 255
    t.string  "attribute5", limit: 255
    t.string  "attribute6", limit: 255
  end

  add_index "s_categories_attributes", ["categoryID"], name: "categoryID", unique: true, using: :btree

  create_table "s_categories_avoid_customergroups", id: false, force: :cascade do |t|
    t.integer "categoryID",      limit: 4, null: false
    t.integer "customergroupID", limit: 4, null: false
  end

  add_index "s_categories_avoid_customergroups", ["categoryID", "customergroupID"], name: "articleID", unique: true, using: :btree

  create_table "s_cms_groups", force: :cascade do |t|
    t.integer "position",    limit: 4,   default: 0, null: false
    t.string  "description", limit: 255,             null: false
  end

  create_table "s_cms_static", force: :cascade do |t|
    t.string  "tpl1variable",     limit: 255,                  null: false
    t.string  "tpl1path",         limit: 255,                  null: false
    t.string  "tpl2variable",     limit: 255,                  null: false
    t.string  "tpl2path",         limit: 255,                  null: false
    t.string  "tpl3variable",     limit: 255,                  null: false
    t.string  "tpl3path",         limit: 255,                  null: false
    t.string  "description",      limit: 255,                  null: false
    t.text    "html",             limit: 16777215,             null: false
    t.string  "grouping",         limit: 255,                  null: false
    t.integer "position",         limit: 4,                    null: false
    t.string  "link",             limit: 255,                  null: false
    t.string  "target",           limit: 255,                  null: false
    t.integer "parentID",         limit: 4,        default: 0, null: false
    t.string  "page_title",       limit: 255,                  null: false
    t.string  "meta_keywords",    limit: 255,                  null: false
    t.string  "meta_description", limit: 255,                  null: false
  end

  add_index "s_cms_static", ["position", "description"], name: "get_menu", using: :btree

  create_table "s_cms_static_attributes", force: :cascade do |t|
    t.integer "cmsStaticID", limit: 4
  end

  add_index "s_cms_static_attributes", ["cmsStaticID"], name: "cmsStaticID", unique: true, using: :btree

  create_table "s_cms_static_groups", force: :cascade do |t|
    t.string  "name",       limit: 255, null: false
    t.string  "key",        limit: 255, null: false
    t.integer "active",     limit: 4,   null: false
    t.integer "mapping_id", limit: 4
  end

  add_index "s_cms_static_groups", ["mapping_id"], name: "mapping_id", using: :btree

  create_table "s_cms_support", force: :cascade do |t|
    t.string  "name",           limit: 255,                     null: false
    t.text    "text",           limit: 16777215,                null: false
    t.string  "email",          limit: 255,                     null: false
    t.text    "email_template", limit: 16777215,                null: false
    t.string  "email_subject",  limit: 255,                     null: false
    t.text    "text2",          limit: 16777215,                null: false
    t.integer "ticket_typeID",  limit: 4,                       null: false
    t.string  "isocode",        limit: 3,        default: "de", null: false
  end

  create_table "s_cms_support_attributes", force: :cascade do |t|
    t.integer "cmsSupportID", limit: 4
  end

  add_index "s_cms_support_attributes", ["cmsSupportID"], name: "cmsSupportID", unique: true, using: :btree

  create_table "s_cms_support_fields", force: :cascade do |t|
    t.string   "error_msg",   limit: 255, null: false
    t.string   "name",        limit: 255, null: false
    t.string   "note",        limit: 255
    t.string   "typ",         limit: 255, null: false
    t.integer  "required",    limit: 4,   null: false
    t.integer  "supportID",   limit: 4,   null: false
    t.string   "label",       limit: 255, null: false
    t.string   "class",       limit: 255, null: false
    t.string   "value",       limit: 255, null: false
    t.datetime "added",                   null: false
    t.integer  "position",    limit: 4,   null: false
    t.string   "ticket_task", limit: 200, null: false
  end

  add_index "s_cms_support_fields", ["name", "supportID"], name: "name", unique: true, using: :btree

  create_table "s_core_acl_privileges", force: :cascade do |t|
    t.integer "resourceID", limit: 4,   null: false
    t.string  "name",       limit: 255, null: false
  end

  add_index "s_core_acl_privileges", ["resourceID"], name: "resourceID", using: :btree

  create_table "s_core_acl_resources", force: :cascade do |t|
    t.string  "name",     limit: 255, null: false
    t.integer "pluginID", limit: 4
  end

  create_table "s_core_acl_roles", force: :cascade do |t|
    t.integer "roleID",      limit: 4, null: false
    t.integer "resourceID",  limit: 4
    t.integer "privilegeID", limit: 4
  end

  add_index "s_core_acl_roles", ["privilegeID"], name: "privilegeID", using: :btree
  add_index "s_core_acl_roles", ["resourceID"], name: "resourceID", using: :btree
  add_index "s_core_acl_roles", ["roleID", "resourceID", "privilegeID"], name: "roleID", unique: true, using: :btree

  create_table "s_core_auth", force: :cascade do |t|
    t.integer  "roleID",          limit: 4,                                null: false
    t.string   "username",        limit: 255,                              null: false
    t.string   "password",        limit: 255,                              null: false
    t.string   "encoder",         limit: 255, default: "LegacyBackendMd5", null: false
    t.string   "apiKey",          limit: 40
    t.integer  "localeID",        limit: 4,                                null: false
    t.string   "sessionID",       limit: 128
    t.datetime "lastlogin",                                                null: false
    t.string   "name",            limit: 255,                              null: false
    t.string   "email",           limit: 120,                              null: false
    t.integer  "active",          limit: 4,   default: 0,                  null: false
    t.integer  "admin",           limit: 4,                                null: false
    t.integer  "salted",          limit: 4,                                null: false
    t.integer  "failedlogins",    limit: 4,                                null: false
    t.datetime "lockeduntil"
    t.boolean  "extended_editor", limit: 1,   default: false,              null: false
    t.boolean  "disabled_cache",  limit: 1,   default: false,              null: false
  end

  add_index "s_core_auth", ["username"], name: "username", unique: true, using: :btree

  create_table "s_core_auth_attributes", force: :cascade do |t|
    t.integer "authID", limit: 4
  end

  add_index "s_core_auth_attributes", ["authID"], name: "authID", unique: true, using: :btree

  create_table "s_core_auth_roles", force: :cascade do |t|
    t.integer "parentID",    limit: 4
    t.string  "name",        limit: 255,   null: false
    t.text    "description", limit: 65535, null: false
    t.string  "source",      limit: 255,   null: false
    t.integer "enabled",     limit: 4,     null: false
    t.integer "admin",       limit: 4,     null: false
  end

  add_index "s_core_auth_roles", ["name"], name: "name", unique: true, using: :btree

  create_table "s_core_config_element_translations", force: :cascade do |t|
    t.integer "element_id",  limit: 4,     null: false
    t.integer "locale_id",   limit: 4,     null: false
    t.string  "label",       limit: 255
    t.text    "description", limit: 65535
  end

  add_index "s_core_config_element_translations", ["element_id", "locale_id"], name: "element_id", unique: true, using: :btree

  create_table "s_core_config_elements", force: :cascade do |t|
    t.integer "form_id",     limit: 4,     null: false
    t.string  "name",        limit: 255,   null: false
    t.text    "value",       limit: 65535
    t.string  "label",       limit: 255
    t.text    "description", limit: 65535
    t.string  "type",        limit: 255,   null: false
    t.integer "required",    limit: 4,     null: false
    t.integer "position",    limit: 4,     null: false
    t.integer "scope",       limit: 4,     null: false
    t.binary  "filters",     limit: 65535
    t.binary  "validators",  limit: 65535
    t.binary  "options",     limit: 65535
  end

  add_index "s_core_config_elements", ["form_id", "name"], name: "form_id_2", unique: true, using: :btree
  add_index "s_core_config_elements", ["form_id"], name: "form_id", using: :btree

  create_table "s_core_config_form_translations", force: :cascade do |t|
    t.integer "form_id",     limit: 4,     null: false
    t.integer "locale_id",   limit: 4,     null: false
    t.string  "label",       limit: 255
    t.text    "description", limit: 65535
  end

  create_table "s_core_config_forms", force: :cascade do |t|
    t.integer "parent_id",   limit: 4
    t.string  "name",        limit: 255,   null: false
    t.string  "label",       limit: 255
    t.text    "description", limit: 65535
    t.integer "position",    limit: 4,     null: false
    t.integer "scope",       limit: 4,     null: false
    t.integer "plugin_id",   limit: 4
  end

  add_index "s_core_config_forms", ["name"], name: "name", unique: true, using: :btree
  add_index "s_core_config_forms", ["parent_id"], name: "parent_id", using: :btree
  add_index "s_core_config_forms", ["plugin_id"], name: "plugin_id", using: :btree

  create_table "s_core_config_mails", force: :cascade do |t|
    t.integer "stateId",     limit: 4
    t.string  "name",        limit: 255,                    null: false
    t.string  "frommail",    limit: 255,                    null: false
    t.string  "fromname",    limit: 255,                    null: false
    t.string  "subject",     limit: 255,                    null: false
    t.text    "content",     limit: 16777215,               null: false
    t.text    "contentHTML", limit: 16777215,               null: false
    t.integer "ishtml",      limit: 4,                      null: false
    t.string  "attachment",  limit: 255,                    null: false
    t.integer "mailtype",    limit: 4,          default: 1, null: false
    t.text    "context",     limit: 4294967295
  end

  add_index "s_core_config_mails", ["name"], name: "name", unique: true, using: :btree
  add_index "s_core_config_mails", ["stateId"], name: "stateId", unique: true, using: :btree

  create_table "s_core_config_mails_attachments", force: :cascade do |t|
    t.integer "mailID",  limit: 4,             null: false
    t.integer "mediaID", limit: 4,             null: false
    t.integer "shopID",  limit: 4, default: 0
  end

  add_index "s_core_config_mails_attachments", ["mailID", "mediaID", "shopID"], name: "mailID", unique: true, using: :btree
  add_index "s_core_config_mails_attachments", ["mediaID"], name: "mediaID", using: :btree
  add_index "s_core_config_mails_attachments", ["shopID"], name: "shopID", using: :btree

  create_table "s_core_config_mails_attributes", force: :cascade do |t|
    t.integer "mailID", limit: 4
  end

  add_index "s_core_config_mails_attributes", ["mailID"], name: "mailID", unique: true, using: :btree

  create_table "s_core_config_values", force: :cascade do |t|
    t.integer "element_id", limit: 4,          null: false
    t.integer "shop_id",    limit: 4
    t.text    "value",      limit: 4294967295, null: false
  end

  add_index "s_core_config_values", ["element_id"], name: "element_id", using: :btree
  add_index "s_core_config_values", ["shop_id"], name: "shop_id", using: :btree

  create_table "s_core_countries", force: :cascade do |t|
    t.string  "countryname",                   limit: 255
    t.string  "countryiso",                    limit: 255
    t.integer "areaID",                        limit: 4
    t.string  "countryen",                     limit: 255
    t.integer "position",                      limit: 4
    t.text    "notice",                        limit: 65535
    t.integer "shippingfree",                  limit: 4
    t.integer "taxfree",                       limit: 4
    t.integer "taxfree_ustid",                 limit: 4
    t.integer "taxfree_ustid_checked",         limit: 4
    t.integer "active",                        limit: 4
    t.string  "iso3",                          limit: 45
    t.integer "display_state_in_registration", limit: 4,     null: false
    t.integer "force_state_in_registration",   limit: 4,     null: false
  end

  add_index "s_core_countries", ["areaID"], name: "areaID", using: :btree

  create_table "s_core_countries_areas", force: :cascade do |t|
    t.string  "name",   limit: 255
    t.integer "active", limit: 4
  end

  add_index "s_core_countries_areas", ["name"], name: "name_UNIQUE", unique: true, using: :btree

  create_table "s_core_countries_attributes", force: :cascade do |t|
    t.integer "countryID", limit: 4
  end

  add_index "s_core_countries_attributes", ["countryID"], name: "countryID", unique: true, using: :btree

  create_table "s_core_countries_states", force: :cascade do |t|
    t.integer "countryID", limit: 4
    t.string  "name",      limit: 255
    t.string  "shortcode", limit: 255, null: false
    t.integer "position",  limit: 4
    t.integer "active",    limit: 4
  end

  add_index "s_core_countries_states", ["countryID"], name: "countryID", using: :btree

  create_table "s_core_countries_states_attributes", force: :cascade do |t|
    t.integer "stateID", limit: 4
  end

  add_index "s_core_countries_states_attributes", ["stateID"], name: "stateID", unique: true, using: :btree

  create_table "s_core_currencies", force: :cascade do |t|
    t.string  "currency",        limit: 255, null: false
    t.string  "name",            limit: 255, null: false
    t.integer "standard",        limit: 4,   null: false
    t.float   "factor",          limit: 53,  null: false
    t.string  "templatechar",    limit: 255, null: false
    t.integer "symbol_position", limit: 4,   null: false
    t.integer "position",        limit: 4,   null: false
  end

  create_table "s_core_customergroups", force: :cascade do |t|
    t.string  "groupkey",              limit: 5,              null: false
    t.string  "description",           limit: 30,             null: false
    t.integer "tax",                   limit: 4,  default: 0, null: false
    t.integer "taxinput",              limit: 4,              null: false
    t.integer "mode",                  limit: 4,              null: false
    t.float   "discount",              limit: 53,             null: false
    t.float   "minimumorder",          limit: 53,             null: false
    t.float   "minimumordersurcharge", limit: 53,             null: false
  end

  add_index "s_core_customergroups", ["groupkey"], name: "groupkey", using: :btree

  create_table "s_core_customergroups_attributes", force: :cascade do |t|
    t.integer "customerGroupID", limit: 4
  end

  add_index "s_core_customergroups_attributes", ["customerGroupID"], name: "customerGroupID", unique: true, using: :btree

  create_table "s_core_customergroups_discounts", force: :cascade do |t|
    t.integer "groupID",             limit: 4,  null: false
    t.float   "basketdiscount",      limit: 53, null: false
    t.float   "basketdiscountstart", limit: 53, null: false
  end

  add_index "s_core_customergroups_discounts", ["groupID", "basketdiscountstart"], name: "groupID", unique: true, using: :btree

  create_table "s_core_customerpricegroups", force: :cascade do |t|
    t.string  "name",   limit: 255, null: false
    t.integer "netto",  limit: 4,   null: false
    t.integer "active", limit: 4,   null: false
  end

  create_table "s_core_detail_states", force: :cascade do |t|
    t.string  "description", limit: 255, null: false
    t.integer "position",    limit: 4,   null: false
    t.integer "mail",        limit: 4,   null: false
  end

  create_table "s_core_documents", force: :cascade do |t|
    t.string  "name",      limit: 255, null: false
    t.string  "template",  limit: 255, null: false
    t.string  "numbers",   limit: 25,  null: false
    t.integer "left",      limit: 4,   null: false
    t.integer "right",     limit: 4,   null: false
    t.integer "top",       limit: 4,   null: false
    t.integer "bottom",    limit: 4,   null: false
    t.integer "pagebreak", limit: 4,   null: false
  end

  create_table "s_core_documents_box", force: :cascade do |t|
    t.integer "documentID", limit: 4,          null: false
    t.string  "name",       limit: 35,         null: false
    t.text    "style",      limit: 4294967295, null: false
    t.text    "value",      limit: 4294967295, null: false
  end

  create_table "s_core_engine_elements", force: :cascade do |t|
    t.integer "groupID",      limit: 4,   default: 0, null: false
    t.string  "domname",      limit: 60,              null: false
    t.string  "default",      limit: 255
    t.string  "type",         limit: 255,             null: false
    t.string  "store",        limit: 255
    t.string  "label",        limit: 255
    t.integer "required",     limit: 4,   default: 0, null: false
    t.integer "position",     limit: 4,   default: 0, null: false
    t.string  "name",         limit: 255,             null: false
    t.string  "layout",       limit: 255
    t.integer "variantable",  limit: 4,               null: false
    t.string  "help",         limit: 255
    t.integer "translatable", limit: 4,               null: false
  end

  add_index "s_core_engine_elements", ["name"], name: "databasefield", unique: true, using: :btree

  create_table "s_core_engine_groups", force: :cascade do |t|
    t.string  "name",        limit: 255,             null: false
    t.string  "label",       limit: 255
    t.string  "layout",      limit: 255
    t.integer "variantable", limit: 4,   default: 0, null: false
    t.integer "position",    limit: 4,               null: false
  end

  create_table "s_core_licenses", force: :cascade do |t|
    t.string  "module",     limit: 255,   null: false
    t.string  "host",       limit: 255,   null: false
    t.string  "label",      limit: 255,   null: false
    t.text    "license",    limit: 65535, null: false
    t.string  "version",    limit: 255,   null: false
    t.string  "notation",   limit: 255
    t.integer "type",       limit: 4,     null: false
    t.integer "source",     limit: 4,     null: false
    t.date    "added",                    null: false
    t.date    "creation"
    t.date    "expiration"
    t.integer "active",     limit: 4,     null: false
    t.integer "plugin_id",  limit: 4
  end

  create_table "s_core_locales", force: :cascade do |t|
    t.string "locale",    limit: 255, null: false
    t.string "language",  limit: 255, null: false
    t.string "territory", limit: 255, null: false
  end

  add_index "s_core_locales", ["locale"], name: "locale", unique: true, using: :btree

  create_table "s_core_log", force: :cascade do |t|
    t.string   "type",       limit: 255,      null: false
    t.string   "key",        limit: 255,      null: false
    t.text     "text",       limit: 16777215, null: false
    t.datetime "date",                        null: false
    t.string   "user",       limit: 255,      null: false
    t.string   "ip_address", limit: 255,      null: false
    t.string   "user_agent", limit: 255,      null: false
    t.string   "value4",     limit: 255,      null: false
  end

  create_table "s_core_menu", force: :cascade do |t|
    t.integer "parent",     limit: 4
    t.string  "hyperlink",  limit: 255,             null: false
    t.string  "name",       limit: 255,             null: false
    t.string  "onclick",    limit: 255
    t.string  "style",      limit: 255
    t.string  "class",      limit: 255
    t.integer "position",   limit: 4,   default: 0, null: false
    t.integer "active",     limit: 4,   default: 0, null: false
    t.integer "pluginID",   limit: 4
    t.integer "resourceID", limit: 4
    t.string  "controller", limit: 255
    t.string  "shortcut",   limit: 255
    t.string  "action",     limit: 255
  end

  add_index "s_core_menu", ["name", "parent"], name: "name", unique: true, using: :btree

  create_table "s_core_multilanguage", force: :cascade do |t|
    t.integer "mainID",               limit: 4
    t.string  "isocode",              limit: 15,                              null: false
    t.integer "locale",               limit: 4,                               null: false
    t.integer "parentID",             limit: 4,                               null: false
    t.string  "flagstorefront",       limit: 255,                             null: false
    t.string  "flagbackend",          limit: 255,                             null: false
    t.integer "skipbackend",          limit: 4,                               null: false
    t.string  "name",                 limit: 255,                             null: false
    t.string  "defaultcustomergroup", limit: 25,                              null: false
    t.string  "template",             limit: 255,                             null: false
    t.string  "doc_template",         limit: 100,      default: "0/de/forms", null: false
    t.integer "separate_numbers",     limit: 1,                               null: false
    t.text    "domainaliase",         limit: 16777215,                        null: false
    t.integer "defaultcurrency",      limit: 4,                               null: false
    t.integer "default",              limit: 4,                               null: false
    t.string  "switchCurrencies",     limit: 255,                             null: false
    t.string  "switchLanguages",      limit: 255,                             null: false
    t.integer "scoped_registration",  limit: 4
    t.integer "fallback",             limit: 4
    t.string  "navigation",           limit: 255,                             null: false
  end

  create_table "s_core_optin", force: :cascade do |t|
    t.datetime "datum",                  null: false
    t.string   "hash",  limit: 255,      null: false
    t.text     "data",  limit: 16777215, null: false
  end

  add_index "s_core_optin", ["datum"], name: "datum", using: :btree
  add_index "s_core_optin", ["hash"], name: "hash", unique: true, using: :btree

  create_table "s_core_payment_data", force: :cascade do |t|
    t.integer "payment_mean_id",  limit: 4,   null: false
    t.integer "user_id",          limit: 4,   null: false
    t.integer "use_billing_data", limit: 4
    t.string  "bankname",         limit: 255
    t.string  "bic",              limit: 50
    t.string  "iban",             limit: 50
    t.string  "account_number",   limit: 50
    t.string  "bank_code",        limit: 50
    t.string  "account_holder",   limit: 50
    t.date    "created_at",                   null: false
  end

  add_index "s_core_payment_data", ["payment_mean_id", "user_id"], name: "payment_mean_id", using: :btree
  add_index "s_core_payment_data", ["payment_mean_id", "user_id"], name: "payment_mean_id_2", unique: true, using: :btree
  add_index "s_core_payment_data", ["user_id"], name: "user_id", using: :btree

  create_table "s_core_payment_instance", force: :cascade do |t|
    t.integer "payment_mean_id", limit: 4
    t.integer "order_id",        limit: 4
    t.integer "user_id",         limit: 4
    t.string  "firstname",       limit: 255
    t.string  "lastname",        limit: 255
    t.string  "address",         limit: 255
    t.string  "zipcode",         limit: 15
    t.string  "city",            limit: 50
    t.string  "account_number",  limit: 50
    t.string  "account_holder",  limit: 255
    t.string  "bank_name",       limit: 255
    t.string  "bank_code",       limit: 255
    t.string  "bic",             limit: 50
    t.string  "iban",            limit: 50
    t.decimal "amount",                      precision: 20, scale: 4
    t.date    "created_at",                                           null: false
  end

  add_index "s_core_payment_instance", ["order_id"], name: "order_id", using: :btree
  add_index "s_core_payment_instance", ["payment_mean_id"], name: "payment_mean_id", using: :btree
  add_index "s_core_payment_instance", ["payment_mean_id"], name: "payment_mean_id_2", using: :btree
  add_index "s_core_payment_instance", ["user_id"], name: "user_id", using: :btree

  create_table "s_core_paymentmeans", force: :cascade do |t|
    t.string  "name",                  limit: 255,                    null: false
    t.string  "description",           limit: 255,                    null: false
    t.string  "template",              limit: 255,                    null: false
    t.string  "class",                 limit: 255,                    null: false
    t.string  "table",                 limit: 70,                     null: false
    t.integer "hide",                  limit: 4,                      null: false
    t.text    "additionaldescription", limit: 16777215,               null: false
    t.float   "debit_percent",         limit: 53,       default: 0.0, null: false
    t.float   "surcharge",             limit: 53,       default: 0.0, null: false
    t.string  "surchargestring",       limit: 255,                    null: false
    t.integer "position",              limit: 4,                      null: false
    t.integer "active",                limit: 4,        default: 0,   null: false
    t.integer "esdactive",             limit: 4,                      null: false
    t.string  "embediframe",           limit: 255,                    null: false
    t.integer "hideprospect",          limit: 4,                      null: false
    t.string  "action",                limit: 255
    t.integer "pluginID",              limit: 4
    t.integer "source",                limit: 4
  end

  add_index "s_core_paymentmeans", ["name"], name: "name", unique: true, using: :btree

  create_table "s_core_paymentmeans_attributes", force: :cascade do |t|
    t.integer "paymentmeanID", limit: 4
  end

  add_index "s_core_paymentmeans_attributes", ["paymentmeanID"], name: "paymentmeanID", unique: true, using: :btree

  create_table "s_core_paymentmeans_countries", id: false, force: :cascade do |t|
    t.integer "paymentID", limit: 4, null: false
    t.integer "countryID", limit: 4, null: false
  end

  create_table "s_core_paymentmeans_subshops", id: false, force: :cascade do |t|
    t.integer "paymentID", limit: 4, null: false
    t.integer "subshopID", limit: 4, null: false
  end

  create_table "s_core_plugins", force: :cascade do |t|
    t.string   "namespace",          limit: 255,                  null: false
    t.string   "name",               limit: 255,                  null: false
    t.string   "label",              limit: 255,                  null: false
    t.string   "source",             limit: 255,                  null: false
    t.text     "description",        limit: 16777215
    t.text     "description_long",   limit: 16777215
    t.integer  "active",             limit: 4,                    null: false
    t.datetime "added",                                           null: false
    t.datetime "installation_date"
    t.datetime "update_date"
    t.datetime "refresh_date"
    t.string   "author",             limit: 255
    t.string   "copyright",          limit: 255
    t.string   "license",            limit: 255
    t.string   "version",            limit: 255,                  null: false
    t.string   "support",            limit: 255
    t.text     "changes",            limit: 16777215
    t.string   "link",               limit: 255
    t.string   "store_version",      limit: 255
    t.datetime "store_date"
    t.integer  "capability_update",  limit: 4,                    null: false
    t.integer  "capability_install", limit: 4,                    null: false
    t.integer  "capability_enable",  limit: 4,                    null: false
    t.integer  "capability_dummy",   limit: 4,        default: 0, null: false
    t.string   "update_source",      limit: 255
    t.string   "update_version",     limit: 255
  end

  add_index "s_core_plugins", ["namespace", "name"], name: "namespace", unique: true, using: :btree

  create_table "s_core_pricegroups", force: :cascade do |t|
    t.string "description", limit: 30, null: false
  end

  create_table "s_core_pricegroups_discounts", force: :cascade do |t|
    t.integer "groupID",         limit: 4,  null: false
    t.integer "customergroupID", limit: 4,  null: false
    t.float   "discount",        limit: 53, null: false
    t.float   "discountstart",   limit: 53, null: false
  end

  add_index "s_core_pricegroups_discounts", ["groupID", "customergroupID", "discountstart"], name: "groupID", unique: true, using: :btree

  create_table "s_core_rewrite", force: :cascade do |t|
    t.string "search",  limit: 255, null: false
    t.string "replace", limit: 255, null: false
  end

  create_table "s_core_rewrite_urls", force: :cascade do |t|
    t.string  "org_path",  limit: 255, null: false
    t.string  "path",      limit: 255, null: false
    t.integer "main",      limit: 4,   null: false
    t.integer "subshopID", limit: 4,   null: false
  end

  add_index "s_core_rewrite_urls", ["org_path"], name: "org_path", using: :btree
  add_index "s_core_rewrite_urls", ["path", "subshopID"], name: "path", unique: true, using: :btree

  create_table "s_core_rulesets", force: :cascade do |t|
    t.integer "paymentID", limit: 4,   null: false
    t.string  "rule1",     limit: 255, null: false
    t.string  "value1",    limit: 255, null: false
    t.string  "rule2",     limit: 255, null: false
    t.string  "value2",    limit: 255, null: false
  end

  create_table "s_core_sessions", force: :cascade do |t|
    t.integer "expiry",    limit: 4,          null: false
    t.string  "expireref", limit: 255
    t.integer "created",   limit: 4,          null: false
    t.integer "modified",  limit: 4,          null: false
    t.text    "data",      limit: 4294967295
  end

  add_index "s_core_sessions", ["expireref"], name: "expireref", using: :btree
  add_index "s_core_sessions", ["expiry"], name: "expiry", using: :btree

  create_table "s_core_sessions_backend", force: :cascade do |t|
    t.integer "expiry",   limit: 4,          null: false
    t.integer "created",  limit: 4,          null: false
    t.integer "modified", limit: 4,          null: false
    t.text    "data",     limit: 4294967295
  end

  add_index "s_core_sessions_backend", ["expiry"], name: "expiry", using: :btree

  create_table "s_core_shop_currencies", id: false, force: :cascade do |t|
    t.integer "shop_id",     limit: 4, null: false
    t.integer "currency_id", limit: 4, null: false
  end

  create_table "s_core_shop_pages", id: false, force: :cascade do |t|
    t.integer "shop_id",  limit: 4, null: false
    t.integer "group_id", limit: 4, null: false
  end

  create_table "s_core_shops", force: :cascade do |t|
    t.integer "main_id",              limit: 4
    t.string  "name",                 limit: 255,               null: false
    t.string  "title",                limit: 255
    t.integer "position",             limit: 4,                 null: false
    t.string  "host",                 limit: 255
    t.string  "base_path",            limit: 255
    t.string  "base_url",             limit: 255
    t.text    "hosts",                limit: 65535,             null: false
    t.integer "secure",               limit: 4,                 null: false
    t.string  "secure_host",          limit: 255
    t.string  "secure_base_path",     limit: 255
    t.integer "template_id",          limit: 4
    t.integer "document_template_id", limit: 4
    t.integer "category_id",          limit: 4
    t.integer "locale_id",            limit: 4
    t.integer "currency_id",          limit: 4
    t.integer "customer_group_id",    limit: 4
    t.integer "fallback_id",          limit: 4
    t.integer "customer_scope",       limit: 4,                 null: false
    t.integer "default",              limit: 4,                 null: false
    t.integer "active",               limit: 4,                 null: false
    t.integer "always_secure",        limit: 4,     default: 0, null: false
  end

  add_index "s_core_shops", ["host"], name: "host", using: :btree
  add_index "s_core_shops", ["main_id"], name: "main_id", using: :btree

  create_table "s_core_snippets", force: :cascade do |t|
    t.string   "namespace", limit: 255,                  null: false
    t.integer  "shopID",    limit: 4,                    null: false
    t.integer  "localeID",  limit: 4,                    null: false
    t.string   "name",      limit: 255,                  null: false
    t.text     "value",     limit: 16777215,             null: false
    t.datetime "created",                                null: false
    t.datetime "updated",                                null: false
    t.integer  "dirty",     limit: 4,        default: 0
  end

  add_index "s_core_snippets", ["namespace", "shopID", "name", "localeID"], name: "namespace", unique: true, using: :btree

  create_table "s_core_states", force: :cascade do |t|
    t.string  "description", limit: 255, null: false
    t.integer "position",    limit: 4,   null: false
    t.string  "group",       limit: 25,  null: false
    t.integer "mail",        limit: 4,   null: false
  end

  create_table "s_core_subscribes", force: :cascade do |t|
    t.string  "subscribe", limit: 255, null: false
    t.integer "type",      limit: 4,   null: false
    t.string  "listener",  limit: 255, null: false
    t.integer "pluginID",  limit: 4
    t.integer "position",  limit: 4,   null: false
  end

  add_index "s_core_subscribes", ["subscribe", "type", "listener"], name: "subscribe", unique: true, using: :btree
  add_index "s_core_subscribes", ["type", "subscribe", "position"], name: "plugin_namespace_init_storage", using: :btree

  create_table "s_core_tax", force: :cascade do |t|
    t.decimal "tax",                    precision: 10, scale: 2, null: false
    t.string  "description", limit: 30,                          null: false
  end

  add_index "s_core_tax", ["tax"], name: "tax", using: :btree

  create_table "s_core_tax_rules", force: :cascade do |t|
    t.integer "areaID",           limit: 4
    t.integer "countryID",        limit: 4
    t.integer "stateID",          limit: 4
    t.integer "groupID",          limit: 4,                            null: false
    t.integer "customer_groupID", limit: 4,                            null: false
    t.decimal "tax",                          precision: 10, scale: 2, null: false
    t.string  "name",             limit: 255,                          null: false
    t.integer "active",           limit: 4,                            null: false
  end

  add_index "s_core_tax_rules", ["areaID"], name: "areaID", using: :btree
  add_index "s_core_tax_rules", ["countryID"], name: "countryID", using: :btree
  add_index "s_core_tax_rules", ["customer_groupID", "areaID", "countryID", "stateID"], name: "tax_rate_by_conditions", using: :btree
  add_index "s_core_tax_rules", ["groupID"], name: "groupID", using: :btree
  add_index "s_core_tax_rules", ["stateID"], name: "stateID", using: :btree

  create_table "s_core_templates", force: :cascade do |t|
    t.string  "template",      limit: 255, null: false
    t.string  "name",          limit: 255, null: false
    t.string  "description",   limit: 255
    t.string  "author",        limit: 255
    t.string  "license",       limit: 255
    t.boolean "esi",           limit: 1,   null: false
    t.boolean "style_support", limit: 1,   null: false
    t.boolean "emotion",       limit: 1,   null: false
    t.integer "version",       limit: 4,   null: false
    t.integer "plugin_id",     limit: 4
  end

  add_index "s_core_templates", ["template"], name: "basename", unique: true, using: :btree

  create_table "s_core_translations", force: :cascade do |t|
    t.string  "objecttype",     limit: 255,        null: false
    t.text    "objectdata",     limit: 4294967295, null: false
    t.integer "objectkey",      limit: 4,          null: false
    t.string  "objectlanguage", limit: 255,        null: false
  end

  add_index "s_core_translations", ["objecttype", "objectkey", "objectlanguage"], name: "objecttype", unique: true, using: :btree

  create_table "s_core_units", force: :cascade do |t|
    t.string "unit",        limit: 255, null: false
    t.string "description", limit: 255, null: false
  end

  create_table "s_core_widget_views", force: :cascade do |t|
    t.integer "widget_id", limit: 4, null: false
    t.integer "auth_id",   limit: 4, null: false
    t.integer "column",    limit: 4, null: false
    t.integer "position",  limit: 4, null: false
  end

  add_index "s_core_widget_views", ["widget_id", "auth_id"], name: "widget_id", using: :btree

  create_table "s_core_widgets", force: :cascade do |t|
    t.string  "name",      limit: 255, null: false
    t.string  "label",     limit: 255
    t.integer "plugin_id", limit: 4
  end

  add_index "s_core_widgets", ["name"], name: "name", unique: true, using: :btree

  create_table "s_crontab", force: :cascade do |t|
    t.string   "name",            limit: 255,      null: false
    t.string   "action",          limit: 255,      null: false
    t.integer  "elementID",       limit: 4
    t.text     "data",            limit: 16777215, null: false
    t.datetime "next"
    t.datetime "start"
    t.integer  "interval",        limit: 4,        null: false
    t.integer  "active",          limit: 4,        null: false
    t.datetime "end"
    t.string   "inform_template", limit: 255,      null: false
    t.string   "inform_mail",     limit: 255,      null: false
    t.integer  "pluginID",        limit: 4
  end

  add_index "s_crontab", ["action"], name: "action", unique: true, using: :btree

  create_table "s_emarketing_banners", force: :cascade do |t|
    t.string   "description",    limit: 60,              null: false
    t.datetime "valid_from"
    t.datetime "valid_to"
    t.string   "img",            limit: 100,             null: false
    t.string   "link",           limit: 255,             null: false
    t.string   "link_target",    limit: 255,             null: false
    t.integer  "categoryID",     limit: 4,   default: 0, null: false
    t.string   "extension",      limit: 25,              null: false
    t.integer  "liveshoppingID", limit: 4,               null: false
  end

  create_table "s_emarketing_banners_attributes", force: :cascade do |t|
    t.integer "bannerID", limit: 4
  end

  add_index "s_emarketing_banners_attributes", ["bannerID"], name: "bannerID", unique: true, using: :btree

  create_table "s_emarketing_banners_statistics", force: :cascade do |t|
    t.integer "bannerID",     limit: 4, null: false
    t.date    "display_date",           null: false
    t.integer "clicks",       limit: 4, null: false
    t.integer "views",        limit: 4, null: false
  end

  add_index "s_emarketing_banners_statistics", ["bannerID", "display_date"], name: "display_date", unique: true, using: :btree
  add_index "s_emarketing_banners_statistics", ["bannerID"], name: "bannerID", using: :btree

  create_table "s_emarketing_lastarticles", force: :cascade do |t|
    t.string   "img",       limit: 255, null: false
    t.string   "name",      limit: 120, null: false
    t.integer  "articleID", limit: 4,   null: false
    t.string   "sessionID", limit: 128
    t.datetime "time",                  null: false
    t.integer  "userID",    limit: 4,   null: false
    t.integer  "shopID",    limit: 4,   null: false
  end

  add_index "s_emarketing_lastarticles", ["articleID", "sessionID", "shopID"], name: "articleID", unique: true, using: :btree
  add_index "s_emarketing_lastarticles", ["sessionID", "time"], name: "get_last_articles", using: :btree
  add_index "s_emarketing_lastarticles", ["sessionID"], name: "sessionID", using: :btree
  add_index "s_emarketing_lastarticles", ["time"], name: "time", using: :btree
  add_index "s_emarketing_lastarticles", ["userID"], name: "userID", using: :btree

  create_table "s_emarketing_partner", force: :cascade do |t|
    t.string  "idcode",         limit: 255,                    null: false
    t.date    "datum",                                         null: false
    t.string  "company",        limit: 255,                    null: false
    t.string  "contact",        limit: 255,                    null: false
    t.string  "street",         limit: 255,                    null: false
    t.string  "streetnumber",   limit: 35,                     null: false
    t.string  "zipcode",        limit: 15,                     null: false
    t.string  "city",           limit: 255,                    null: false
    t.string  "phone",          limit: 50,                     null: false
    t.string  "fax",            limit: 50,                     null: false
    t.string  "country",        limit: 255,                    null: false
    t.string  "email",          limit: 100,                    null: false
    t.string  "web",            limit: 255,                    null: false
    t.text    "profil",         limit: 16777215,               null: false
    t.float   "fix",            limit: 53,       default: 0.0, null: false
    t.float   "percent",        limit: 53,       default: 0.0, null: false
    t.integer "cookielifetime", limit: 4,        default: 0,   null: false
    t.integer "active",         limit: 4,        default: 0,   null: false
    t.integer "userID",         limit: 4
  end

  create_table "s_emarketing_promotion_articles", force: :cascade do |t|
    t.integer "parentID",           limit: 4,   default: 0,   null: false
    t.string  "articleordernumber", limit: 30,  default: "0", null: false
    t.string  "name",               limit: 255,               null: false
    t.string  "type",               limit: 30,                null: false
    t.integer "position",           limit: 4,   default: 0,   null: false
    t.string  "image",              limit: 255,               null: false
    t.string  "link",               limit: 255,               null: false
    t.string  "target",             limit: 255,               null: false
  end

  create_table "s_emarketing_promotion_banner", force: :cascade do |t|
    t.integer "parentID",    limit: 4,   null: false
    t.string  "image",       limit: 255, null: false
    t.string  "link",        limit: 255, null: false
    t.string  "linkTarget",  limit: 255, null: false
    t.string  "description", limit: 255, null: false
  end

  create_table "s_emarketing_promotion_containers", force: :cascade do |t|
    t.integer "promotionID", limit: 4,   default: 0, null: false
    t.string  "container",   limit: 255,             null: false
    t.string  "type",        limit: 255,             null: false
    t.string  "description", limit: 255,             null: false
    t.integer "position",    limit: 4,   default: 0, null: false
  end

  create_table "s_emarketing_promotion_html", force: :cascade do |t|
    t.integer "parentID", limit: 4,        default: 0, null: false
    t.string  "headline", limit: 255,                  null: false
    t.text    "html",     limit: 16777215,             null: false
  end

  create_table "s_emarketing_promotion_links", force: :cascade do |t|
    t.integer "parentID",    limit: 4,   default: 0, null: false
    t.string  "description", limit: 255,             null: false
    t.string  "link",        limit: 255,             null: false
    t.string  "target",      limit: 255,             null: false
    t.integer "position",    limit: 4,   default: 0, null: false
  end

  create_table "s_emarketing_promotion_main", force: :cascade do |t|
    t.integer "parentID",      limit: 4,   null: false
    t.string  "positionGroup", limit: 50,  null: false
    t.date    "datum",                     null: false
    t.date    "start",                     null: false
    t.date    "end",                       null: false
    t.string  "image",         limit: 255, null: false
    t.string  "description",   limit: 255, null: false
    t.string  "link",          limit: 255, null: false
    t.string  "linktarget",    limit: 255, null: false
    t.integer "active",        limit: 4,   null: false
    t.integer "position",      limit: 4,   null: false
  end

  add_index "s_emarketing_promotion_main", ["parentID"], name: "parentID", using: :btree

  create_table "s_emarketing_promotion_positions", force: :cascade do |t|
    t.integer "promotionID", limit: 4, default: 0, null: false
    t.integer "containerID", limit: 4, default: 0, null: false
    t.integer "position",    limit: 4, default: 0, null: false
  end

  create_table "s_emarketing_promotions", force: :cascade do |t|
    t.string  "description",    limit: 50,                null: false
    t.integer "category",       limit: 4,   default: 0,   null: false
    t.string  "mode",           limit: 40,                null: false
    t.string  "ordernumber",    limit: 255, default: "0", null: false
    t.string  "link",           limit: 255,               null: false
    t.string  "link_target",    limit: 50,                null: false
    t.date    "valid_from",                               null: false
    t.date    "valid_to",                                 null: false
    t.integer "position",       limit: 4,   default: 0,   null: false
    t.string  "img",            limit: 255,               null: false
    t.integer "liveshoppingID", limit: 4,                 null: false
  end

  add_index "s_emarketing_promotions", ["category"], name: "category", using: :btree

  create_table "s_emarketing_referer", force: :cascade do |t|
    t.integer "userID",  limit: 4,        null: false
    t.text    "referer", limit: 16777215, null: false
    t.date    "date",                     null: false
  end

  create_table "s_emarketing_tellafriend", force: :cascade do |t|
    t.date    "datum",                            null: false
    t.string  "recipient", limit: 50,             null: false
    t.integer "sender",    limit: 4,  default: 0, null: false
    t.integer "confirmed", limit: 4,  default: 0, null: false
  end

  create_table "s_emarketing_voucher_codes", force: :cascade do |t|
    t.integer "voucherID", limit: 4,   default: 0, null: false
    t.integer "userID",    limit: 4
    t.string  "code",      limit: 255,             null: false
    t.integer "cashed",    limit: 4,               null: false
  end

  add_index "s_emarketing_voucher_codes", ["code"], name: "code", unique: true, using: :btree

  create_table "s_emarketing_vouchers", force: :cascade do |t|
    t.string  "description",      limit: 255,                    null: false
    t.string  "vouchercode",      limit: 100,                    null: false
    t.integer "numberofunits",    limit: 4,        default: 0,   null: false
    t.float   "value",            limit: 53,       default: 0.0, null: false
    t.float   "minimumcharge",    limit: 53,       default: 0.0, null: false
    t.integer "shippingfree",     limit: 4,        default: 0,   null: false
    t.integer "bindtosupplier",   limit: 4
    t.date    "valid_from"
    t.date    "valid_to"
    t.string  "ordercode",        limit: 100,                    null: false
    t.integer "modus",            limit: 4,        default: 0,   null: false
    t.integer "percental",        limit: 4,                      null: false
    t.integer "numorder",         limit: 4,                      null: false
    t.integer "customergroup",    limit: 4
    t.text    "restrictarticles", limit: 16777215,               null: false
    t.integer "strict",           limit: 4,                      null: false
    t.integer "subshopID",        limit: 4
    t.string  "taxconfig",        limit: 15,                     null: false
  end

  create_table "s_emarketing_vouchers_attributes", force: :cascade do |t|
    t.integer "voucherID", limit: 4
  end

  add_index "s_emarketing_vouchers_attributes", ["voucherID"], name: "voucherID", unique: true, using: :btree

  create_table "s_emarketing_vouchers_cashed", force: :cascade do |t|
    t.integer "userID",    limit: 4, default: 0, null: false
    t.integer "voucherID", limit: 4,             null: false
  end

  create_table "s_emotion", force: :cascade do |t|
    t.integer  "active",             limit: 4,     null: false
    t.string   "name",               limit: 255,   null: false
    t.integer  "cols",               limit: 4
    t.integer  "cell_height",        limit: 4,     null: false
    t.integer  "article_height",     limit: 4,     null: false
    t.integer  "container_width",    limit: 4,     null: false
    t.integer  "rows",               limit: 4,     null: false
    t.datetime "valid_from"
    t.datetime "valid_to"
    t.integer  "userID",             limit: 4
    t.integer  "show_listing",       limit: 4,     null: false
    t.integer  "is_landingpage",     limit: 4,     null: false
    t.string   "landingpage_block",  limit: 255,   null: false
    t.string   "landingpage_teaser", limit: 255,   null: false
    t.string   "seo_keywords",       limit: 255,   null: false
    t.text     "seo_description",    limit: 65535, null: false
    t.datetime "create_date"
    t.datetime "modified"
    t.integer  "grid_id",            limit: 4,     null: false
    t.integer  "template_id",        limit: 4
  end

  create_table "s_emotion_attributes", force: :cascade do |t|
    t.integer "emotionID", limit: 4
  end

  add_index "s_emotion_attributes", ["emotionID"], name: "emotionID", unique: true, using: :btree

  create_table "s_emotion_categories", force: :cascade do |t|
    t.integer "emotion_id",  limit: 4, null: false
    t.integer "category_id", limit: 4, null: false
  end

  create_table "s_emotion_element", force: :cascade do |t|
    t.integer "emotionID",   limit: 4, null: false
    t.integer "componentID", limit: 4, null: false
    t.integer "start_row",   limit: 4, null: false
    t.integer "start_col",   limit: 4, null: false
    t.integer "end_row",     limit: 4, null: false
    t.integer "end_col",     limit: 4, null: false
  end

  add_index "s_emotion_element", ["emotionID", "start_row", "start_col"], name: "get_emotion_elements", using: :btree

  create_table "s_emotion_element_value", force: :cascade do |t|
    t.integer "emotionID",   limit: 4,     null: false
    t.integer "elementID",   limit: 4,     null: false
    t.integer "componentID", limit: 4,     null: false
    t.integer "fieldID",     limit: 4,     null: false
    t.text    "value",       limit: 65535
  end

  add_index "s_emotion_element_value", ["elementID"], name: "emotionID", using: :btree
  add_index "s_emotion_element_value", ["fieldID"], name: "fieldID", using: :btree

  create_table "s_emotion_grid", force: :cascade do |t|
    t.string  "name",           limit: 255, null: false
    t.integer "cols",           limit: 4,   null: false
    t.integer "rows",           limit: 4,   null: false
    t.integer "cell_height",    limit: 4,   null: false
    t.integer "article_height", limit: 4,   null: false
    t.integer "gutter",         limit: 4,   null: false
  end

  create_table "s_emotion_templates", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "file", limit: 255, null: false
  end

  create_table "s_export", force: :cascade do |t|
    t.string   "name",            limit: 255,                    null: false
    t.datetime "last_export",                                    null: false
    t.integer  "active",          limit: 4,          default: 0, null: false
    t.string   "hash",            limit: 255,                    null: false
    t.integer  "show",            limit: 4,          default: 1, null: false
    t.integer  "count_articles",  limit: 4,                      null: false
    t.datetime "expiry",                                         null: false
    t.integer  "interval",        limit: 4,                      null: false
    t.integer  "formatID",        limit: 4,          default: 1, null: false
    t.datetime "last_change",                                    null: false
    t.string   "filename",        limit: 255,                    null: false
    t.integer  "encodingID",      limit: 4,          default: 1, null: false
    t.integer  "categoryID",      limit: 4
    t.integer  "currencyID",      limit: 4
    t.integer  "customergroupID", limit: 4
    t.string   "partnerID",       limit: 255
    t.integer  "languageID",      limit: 4
    t.integer  "active_filter",   limit: 4,          default: 1, null: false
    t.integer  "image_filter",    limit: 4,          default: 0, null: false
    t.integer  "stockmin_filter", limit: 4,          default: 0, null: false
    t.integer  "instock_filter",  limit: 4,                      null: false
    t.float    "price_filter",    limit: 53,                     null: false
    t.text     "own_filter",      limit: 16777215,               null: false
    t.text     "header",          limit: 4294967295,             null: false
    t.text     "body",            limit: 4294967295,             null: false
    t.text     "footer",          limit: 4294967295,             null: false
    t.integer  "count_filter",    limit: 4,                      null: false
    t.integer  "multishopID",     limit: 4
    t.integer  "variant_export",  limit: 4,          default: 1, null: false
    t.datetime "cache_refreshed"
  end

  create_table "s_export_articles", id: false, force: :cascade do |t|
    t.integer "feedID",    limit: 4, null: false
    t.integer "articleID", limit: 4, null: false
  end

  create_table "s_export_attributes", force: :cascade do |t|
    t.integer "exportID", limit: 4
  end

  add_index "s_export_attributes", ["exportID"], name: "exportID", unique: true, using: :btree

  create_table "s_export_categories", id: false, force: :cascade do |t|
    t.integer "feedID",     limit: 4, null: false
    t.integer "categoryID", limit: 4, null: false
  end

  create_table "s_export_suppliers", id: false, force: :cascade do |t|
    t.integer "feedID",     limit: 4, null: false
    t.integer "supplierID", limit: 4, null: false
  end

  create_table "s_filter", force: :cascade do |t|
    t.string  "name",       limit: 255, null: false
    t.integer "position",   limit: 4,   null: false
    t.integer "comparable", limit: 4,   null: false
    t.integer "sortmode",   limit: 4,   null: false
  end

  add_index "s_filter", ["position"], name: "get_sets_query", using: :btree

  create_table "s_filter_articles", id: false, force: :cascade do |t|
    t.integer "articleID", limit: 4, null: false
    t.integer "valueID",   limit: 4, null: false
  end

  add_index "s_filter_articles", ["articleID"], name: "articleID", using: :btree
  add_index "s_filter_articles", ["valueID"], name: "valueID", using: :btree

  create_table "s_filter_attributes", force: :cascade do |t|
    t.integer "filterID", limit: 4
  end

  add_index "s_filter_attributes", ["filterID"], name: "filterID", unique: true, using: :btree

  create_table "s_filter_options", force: :cascade do |t|
    t.string  "name",       limit: 255, null: false
    t.integer "filterable", limit: 4,   null: false
    t.string  "default",    limit: 255, null: false
  end

  add_index "s_filter_options", ["name"], name: "get_options_query", using: :btree

  create_table "s_filter_relations", force: :cascade do |t|
    t.integer "groupID",  limit: 4, null: false
    t.integer "optionID", limit: 4, null: false
    t.integer "position", limit: 4, null: false
  end

  add_index "s_filter_relations", ["groupID", "optionID"], name: "groupID", unique: true, using: :btree
  add_index "s_filter_relations", ["groupID", "position"], name: "get_set_assigns_query", using: :btree
  add_index "s_filter_relations", ["groupID"], name: "groupID_2", using: :btree
  add_index "s_filter_relations", ["optionID"], name: "optionID", using: :btree

  create_table "s_filter_values", force: :cascade do |t|
    t.integer "optionID",      limit: 4,                                          null: false
    t.string  "value",         limit: 255,                                        null: false
    t.integer "position",      limit: 4,                                          null: false
    t.decimal "value_numeric",             precision: 10, scale: 2, default: 0.0, null: false
  end

  add_index "s_filter_values", ["optionID", "position", "id"], name: "filters_order_by_position", using: :btree
  add_index "s_filter_values", ["optionID", "position"], name: "get_property_value_by_option_id_query", using: :btree
  add_index "s_filter_values", ["optionID", "value", "id"], name: "filters_order_by_alphanumeric", using: :btree
  add_index "s_filter_values", ["optionID", "value"], name: "optionID", unique: true, using: :btree
  add_index "s_filter_values", ["optionID", "value_numeric", "id"], name: "filters_order_by_numeric", using: :btree
  add_index "s_filter_values", ["optionID"], name: "optionID_2", using: :btree

  create_table "s_library_component", force: :cascade do |t|
    t.string  "name",             limit: 255,   null: false
    t.string  "x_type",           limit: 255,   null: false
    t.string  "convert_function", limit: 255
    t.text    "description",      limit: 65535, null: false
    t.string  "template",         limit: 255,   null: false
    t.string  "cls",              limit: 255,   null: false
    t.integer "pluginID",         limit: 4
  end

  create_table "s_library_component_field", force: :cascade do |t|
    t.integer "componentID",   limit: 4,     null: false
    t.string  "name",          limit: 255,   null: false
    t.string  "x_type",        limit: 255,   null: false
    t.string  "value_type",    limit: 255,   null: false
    t.string  "field_label",   limit: 255,   null: false
    t.string  "support_text",  limit: 255,   null: false
    t.string  "help_title",    limit: 255,   null: false
    t.text    "help_text",     limit: 65535, null: false
    t.string  "store",         limit: 255,   null: false
    t.string  "display_field", limit: 255,   null: false
    t.string  "value_field",   limit: 255,   null: false
    t.string  "default_value", limit: 255,   null: false
    t.integer "allow_blank",   limit: 4,     null: false
  end

  create_table "s_media", force: :cascade do |t|
    t.integer "albumID",     limit: 4,     null: false
    t.string  "name",        limit: 255,   null: false
    t.text    "description", limit: 65535, null: false
    t.string  "path",        limit: 255,   null: false
    t.string  "type",        limit: 50,    null: false
    t.string  "extension",   limit: 20,    null: false
    t.integer "file_size",   limit: 4,     null: false
    t.integer "userID",      limit: 4,     null: false
    t.date    "created",                   null: false
  end

  add_index "s_media", ["albumID"], name: "Album", using: :btree
  add_index "s_media", ["path"], name: "path", using: :btree

  create_table "s_media_album", force: :cascade do |t|
    t.string  "name",     limit: 255, null: false
    t.integer "parentID", limit: 4
    t.integer "position", limit: 4,   null: false
  end

  create_table "s_media_album_settings", force: :cascade do |t|
    t.integer "albumID",           limit: 4,     null: false
    t.integer "create_thumbnails", limit: 4,     null: false
    t.text    "thumbnail_size",    limit: 65535, null: false
    t.string  "icon",              limit: 50,    null: false
  end

  add_index "s_media_album_settings", ["albumID"], name: "albumID", unique: true, using: :btree

  create_table "s_media_association", force: :cascade do |t|
    t.integer "mediaID",    limit: 4,  null: false
    t.string  "targetType", limit: 50, null: false
    t.integer "targetID",   limit: 4,  null: false
  end

  add_index "s_media_association", ["mediaID"], name: "Media", using: :btree
  add_index "s_media_association", ["targetID", "targetType"], name: "Target", using: :btree

  create_table "s_media_attributes", force: :cascade do |t|
    t.integer "mediaID", limit: 4
  end

  add_index "s_media_attributes", ["mediaID"], name: "mediaID", unique: true, using: :btree

  create_table "s_order", force: :cascade do |t|
    t.string   "ordernumber",          limit: 30
    t.integer  "userID",               limit: 4
    t.float    "invoice_amount",       limit: 53,       default: 0.0, null: false
    t.float    "invoice_amount_net",   limit: 53,                     null: false
    t.float    "invoice_shipping",     limit: 53,       default: 0.0, null: false
    t.float    "invoice_shipping_net", limit: 53,                     null: false
    t.datetime "ordertime"
    t.integer  "status",               limit: 4,        default: 0,   null: false
    t.integer  "cleared",              limit: 4,        default: 0,   null: false
    t.integer  "paymentID",            limit: 4,        default: 0,   null: false
    t.string   "transactionID",        limit: 255,                    null: false
    t.text     "comment",              limit: 16777215,               null: false
    t.text     "customercomment",      limit: 16777215,               null: false
    t.text     "internalcomment",      limit: 16777215,               null: false
    t.integer  "net",                  limit: 4,                      null: false
    t.integer  "taxfree",              limit: 4,                      null: false
    t.string   "partnerID",            limit: 255,                    null: false
    t.string   "temporaryID",          limit: 255,                    null: false
    t.text     "referer",              limit: 16777215,               null: false
    t.datetime "cleareddate"
    t.string   "trackingcode",         limit: 255,                    null: false
    t.string   "language",             limit: 10,                     null: false
    t.integer  "dispatchID",           limit: 4,                      null: false
    t.string   "currency",             limit: 5,                      null: false
    t.float    "currencyFactor",       limit: 53,                     null: false
    t.integer  "subshopID",            limit: 4,                      null: false
    t.string   "remote_addr",          limit: 255,                    null: false
  end

  add_index "s_order", ["cleared"], name: "cleared", using: :btree
  add_index "s_order", ["ordernumber"], name: "ordernumber", using: :btree
  add_index "s_order", ["ordertime"], name: "ordertime", using: :btree
  add_index "s_order", ["partnerID"], name: "partnerID", using: :btree
  add_index "s_order", ["paymentID"], name: "paymentID", using: :btree
  add_index "s_order", ["status"], name: "status", using: :btree
  add_index "s_order", ["temporaryID"], name: "temporaryID", using: :btree
  add_index "s_order", ["transactionID"], name: "transactionID", using: :btree
  add_index "s_order", ["userID"], name: "userID", using: :btree

  create_table "s_order_attributes", force: :cascade do |t|
    t.integer "orderID",                         limit: 4
    t.string  "attribute1",                      limit: 255
    t.string  "attribute2",                      limit: 255
    t.string  "attribute3",                      limit: 255
    t.string  "attribute4",                      limit: 255
    t.string  "attribute5",                      limit: 255
    t.string  "attribute6",                      limit: 255
    t.string  "swag_payal_billing_agreement_id", limit: 255
    t.boolean "swag_payal_express",              limit: 1
    t.string  "swag_billsafe_iban",              limit: 34
    t.string  "swag_billsafe_bic",               limit: 11
  end

  add_index "s_order_attributes", ["orderID"], name: "orderID", unique: true, using: :btree

  create_table "s_order_basket", force: :cascade do |t|
    t.string   "sessionID",               limit: 128
    t.integer  "userID",                  limit: 4,        default: 0,   null: false
    t.string   "articlename",             limit: 255,                    null: false
    t.integer  "articleID",               limit: 4,        default: 0,   null: false
    t.string   "ordernumber",             limit: 30,                     null: false
    t.integer  "shippingfree",            limit: 4,        default: 0,   null: false
    t.integer  "quantity",                limit: 4,        default: 0,   null: false
    t.float    "price",                   limit: 53,       default: 0.0, null: false
    t.float    "netprice",                limit: 53,       default: 0.0, null: false
    t.float    "tax_rate",                limit: 53,                     null: false
    t.datetime "datum",                                                  null: false
    t.integer  "modus",                   limit: 4,        default: 0,   null: false
    t.integer  "esdarticle",              limit: 4,                      null: false
    t.string   "partnerID",               limit: 45,                     null: false
    t.string   "lastviewport",            limit: 255,                    null: false
    t.string   "useragent",               limit: 255,                    null: false
    t.text     "config",                  limit: 16777215,               null: false
    t.float    "currencyFactor",          limit: 53,                     null: false
    t.integer  "liveshoppingID",          limit: 4,                      null: false
    t.integer  "bundleID",                limit: 4,                      null: false
    t.string   "bundle_join_ordernumber", limit: 255,                    null: false
  end

  add_index "s_order_basket", ["articleID"], name: "articleID", using: :btree
  add_index "s_order_basket", ["datum"], name: "datum", using: :btree
  add_index "s_order_basket", ["sessionID", "id", "datum"], name: "get_basket", using: :btree
  add_index "s_order_basket", ["sessionID"], name: "sessionID", using: :btree

  create_table "s_order_basket_attributes", force: :cascade do |t|
    t.integer "basketID",                           limit: 4
    t.string  "attribute1",                         limit: 255
    t.string  "attribute2",                         limit: 255
    t.string  "attribute3",                         limit: 255
    t.string  "attribute4",                         limit: 255
    t.string  "attribute5",                         limit: 255
    t.string  "attribute6",                         limit: 255
    t.decimal "swp_refundsystem_refund_price",                    precision: 15, scale: 4
    t.string  "swp_refundsystem_refund_type",       limit: 6
    t.integer "swp_refundsystem_refund_taxID",      limit: 4
    t.float   "swp_refundsystem_refund_tax_rate",   limit: 53
    t.string  "swp_refundsystem_refund_total_type", limit: 6
    t.text    "swp_refundsystem_refund_total_ids",  limit: 65535
  end

  add_index "s_order_basket_attributes", ["basketID"], name: "basketID", unique: true, using: :btree

  create_table "s_order_billingaddress", force: :cascade do |t|
    t.integer "userID",         limit: 4
    t.integer "orderID",        limit: 4,               null: false
    t.string  "company",        limit: 255,             null: false
    t.string  "department",     limit: 35,              null: false
    t.string  "salutation",     limit: 30,              null: false
    t.string  "customernumber", limit: 30,              null: false
    t.string  "firstname",      limit: 50,              null: false
    t.string  "lastname",       limit: 60,              null: false
    t.string  "street",         limit: 100,             null: false
    t.string  "streetnumber",   limit: 50,              null: false
    t.string  "zipcode",        limit: 50,              null: false
    t.string  "city",           limit: 70,              null: false
    t.string  "phone",          limit: 40,              null: false
    t.string  "fax",            limit: 40,              null: false
    t.integer "countryID",      limit: 4,   default: 0, null: false
    t.integer "stateID",        limit: 4,               null: false
    t.string  "ustid",          limit: 50,              null: false
  end

  add_index "s_order_billingaddress", ["orderID"], name: "orderID", unique: true, using: :btree
  add_index "s_order_billingaddress", ["userID"], name: "userid", using: :btree

  create_table "s_order_billingaddress_attributes", force: :cascade do |t|
    t.integer "billingID", limit: 4
    t.string  "text1",     limit: 255
    t.string  "text2",     limit: 255
    t.string  "text3",     limit: 255
    t.string  "text4",     limit: 255
    t.string  "text5",     limit: 255
    t.string  "text6",     limit: 255
  end

  add_index "s_order_billingaddress_attributes", ["billingID"], name: "billingID", unique: true, using: :btree

  create_table "s_order_comparisons", force: :cascade do |t|
    t.string   "sessionID",   limit: 128
    t.integer  "userID",      limit: 4,   default: 0, null: false
    t.string   "articlename", limit: 255,             null: false
    t.integer  "articleID",   limit: 4,   default: 0, null: false
    t.datetime "datum",                               null: false
  end

  add_index "s_order_comparisons", ["articleID"], name: "articleID", using: :btree
  add_index "s_order_comparisons", ["datum"], name: "datum", using: :btree
  add_index "s_order_comparisons", ["sessionID"], name: "sessionID", using: :btree

  create_table "s_order_details", force: :cascade do |t|
    t.integer "orderID",            limit: 4,        default: 0,   null: false
    t.string  "ordernumber",        limit: 40,                     null: false
    t.integer "articleID",          limit: 4,        default: 0,   null: false
    t.string  "articleordernumber", limit: 30,                     null: false
    t.float   "price",              limit: 53,       default: 0.0, null: false
    t.integer "quantity",           limit: 4,        default: 0,   null: false
    t.string  "name",               limit: 255,                    null: false
    t.integer "status",             limit: 4,        default: 0,   null: false
    t.integer "shipped",            limit: 4,        default: 0,   null: false
    t.integer "shippedgroup",       limit: 4,        default: 0,   null: false
    t.date    "releasedate"
    t.integer "modus",              limit: 4,                      null: false
    t.integer "esdarticle",         limit: 4,                      null: false
    t.integer "taxID",              limit: 4
    t.float   "tax_rate",           limit: 53,                     null: false
    t.text    "config",             limit: 16777215,               null: false
    t.string  "ean",                limit: 255
    t.string  "unit",               limit: 255
    t.string  "pack_unit",          limit: 255
  end

  add_index "s_order_details", ["articleID"], name: "articleID", using: :btree
  add_index "s_order_details", ["articleordernumber"], name: "articleordernumber", using: :btree
  add_index "s_order_details", ["orderID"], name: "orderID", using: :btree
  add_index "s_order_details", ["ordernumber"], name: "ordernumber", using: :btree

  create_table "s_order_details_attributes", force: :cascade do |t|
    t.integer "detailID",   limit: 4
    t.string  "attribute1", limit: 255
    t.string  "attribute2", limit: 255
    t.string  "attribute3", limit: 255
    t.string  "attribute4", limit: 255
    t.string  "attribute5", limit: 255
    t.string  "attribute6", limit: 255
  end

  add_index "s_order_details_attributes", ["detailID"], name: "detailID", unique: true, using: :btree

  create_table "s_order_documents", primary_key: "ID", force: :cascade do |t|
    t.date    "date",                null: false
    t.integer "type",    limit: 4,   null: false
    t.integer "userID",  limit: 4,   null: false
    t.integer "orderID", limit: 4,   null: false
    t.float   "amount",  limit: 53,  null: false
    t.integer "docID",   limit: 4,   null: false
    t.string  "hash",    limit: 255, null: false
  end

  add_index "s_order_documents", ["orderID"], name: "orderID", using: :btree
  add_index "s_order_documents", ["userID"], name: "userID", using: :btree

  create_table "s_order_documents_attributes", force: :cascade do |t|
    t.integer "documentID", limit: 4
  end

  add_index "s_order_documents_attributes", ["documentID"], name: "documentID", unique: true, using: :btree

  create_table "s_order_esd", force: :cascade do |t|
    t.integer  "serialID",       limit: 4, default: 0, null: false
    t.integer  "esdID",          limit: 4, default: 0, null: false
    t.integer  "userID",         limit: 4, default: 0, null: false
    t.integer  "orderID",        limit: 4, default: 0, null: false
    t.integer  "orderdetailsID", limit: 4, default: 0, null: false
    t.datetime "datum",                                null: false
  end

  create_table "s_order_history", force: :cascade do |t|
    t.integer  "orderID",                    limit: 4,     null: false
    t.integer  "userID",                     limit: 4
    t.integer  "previous_order_status_id",   limit: 4
    t.integer  "order_status_id",            limit: 4
    t.integer  "previous_payment_status_id", limit: 4
    t.integer  "payment_status_id",          limit: 4
    t.text     "comment",                    limit: 65535, null: false
    t.datetime "change_date"
  end

  add_index "s_order_history", ["orderID"], name: "order", using: :btree
  add_index "s_order_history", ["order_status_id"], name: "current_order_status", using: :btree
  add_index "s_order_history", ["payment_status_id"], name: "current_payment_status", using: :btree
  add_index "s_order_history", ["previous_order_status_id"], name: "previous_order_status", using: :btree
  add_index "s_order_history", ["previous_payment_status_id"], name: "previous_payment_status", using: :btree
  add_index "s_order_history", ["userID"], name: "user", using: :btree

  create_table "s_order_notes", force: :cascade do |t|
    t.string   "sUniqueID",   limit: 70,              null: false
    t.integer  "userID",      limit: 4,   default: 0, null: false
    t.string   "articlename", limit: 255,             null: false
    t.integer  "articleID",   limit: 4,   default: 0, null: false
    t.string   "ordernumber", limit: 30,              null: false
    t.datetime "datum",                               null: false
  end

  add_index "s_order_notes", ["sUniqueID", "userID"], name: "basket_count_notes", using: :btree

  create_table "s_order_number", force: :cascade do |t|
    t.integer "number", limit: 4,   null: false
    t.string  "name",   limit: 255, null: false
    t.string  "desc",   limit: 255, null: false
  end

  add_index "s_order_number", ["name"], name: "name", unique: true, using: :btree

  create_table "s_order_shippingaddress", force: :cascade do |t|
    t.integer "userID",       limit: 4
    t.integer "orderID",      limit: 4,   null: false
    t.string  "company",      limit: 255, null: false
    t.string  "department",   limit: 35,  null: false
    t.string  "salutation",   limit: 30,  null: false
    t.string  "firstname",    limit: 50,  null: false
    t.string  "lastname",     limit: 60,  null: false
    t.string  "street",       limit: 100, null: false
    t.string  "streetnumber", limit: 50,  null: false
    t.string  "zipcode",      limit: 50,  null: false
    t.string  "city",         limit: 70,  null: false
    t.integer "countryID",    limit: 4,   null: false
    t.integer "stateID",      limit: 4,   null: false
  end

  add_index "s_order_shippingaddress", ["orderID"], name: "orderID", unique: true, using: :btree
  add_index "s_order_shippingaddress", ["userID"], name: "userID", using: :btree

  create_table "s_order_shippingaddress_attributes", force: :cascade do |t|
    t.integer "shippingID", limit: 4
    t.string  "text1",      limit: 255
    t.string  "text2",      limit: 255
    t.string  "text3",      limit: 255
    t.string  "text4",      limit: 255
    t.string  "text5",      limit: 255
    t.string  "text6",      limit: 255
  end

  add_index "s_order_shippingaddress_attributes", ["shippingID"], name: "shippingID", unique: true, using: :btree

  create_table "s_plugin_dpd_config", force: :cascade do |t|
    t.string "name",  limit: 255,        null: false
    t.text   "value", limit: 4294967295, null: false
  end

  add_index "s_plugin_dpd_config", ["name"], name: "UNIQ_2A452F4F5E237E06", unique: true, using: :btree

  create_table "s_plugin_dpd_export", force: :cascade do |t|
    t.datetime "insertdate",                       null: false
    t.datetime "updatetime"
    t.string   "customernumber",       limit: 30,  null: false
    t.string   "ordernumber",          limit: 30,  null: false
    t.string   "trackingcode",         limit: 30
    t.string   "company",              limit: 255
    t.string   "name",                 limit: 255, null: false
    t.string   "toHands",              limit: 255, null: false
    t.string   "email",                limit: 255, null: false
    t.string   "phone",                limit: 255, null: false
    t.string   "weight",               limit: 30,  null: false
    t.string   "zip",                  limit: 10,  null: false
    t.string   "city",                 limit: 255, null: false
    t.string   "street",               limit: 255, null: false
    t.string   "country",              limit: 10,  null: false
    t.integer  "state",                limit: 4,   null: false
    t.string   "method",               limit: 255, null: false
    t.float    "codInvoice",           limit: 53,  null: false
    t.string   "codCurrency",          limit: 10,  null: false
    t.string   "codPurpose",           limit: 255
    t.string   "codCollection",        limit: 255
    t.string   "idCheckName",          limit: 255
    t.string   "reference1",           limit: 255
    t.string   "reference2",           limit: 255
    t.string   "notificationtype",     limit: 255
    t.string   "notificationemail",    limit: 255
    t.string   "notificationevent",    limit: 255
    t.string   "notificationlanguage", limit: 255
  end

  add_index "s_plugin_dpd_export", ["ordernumber"], name: "UNIQ_BC4316A79F368735", unique: true, using: :btree

  create_table "s_plugin_mopt_payone_api_log", force: :cascade do |t|
    t.string   "request",          limit: 100,        null: false
    t.string   "response",         limit: 100,        null: false
    t.boolean  "live_mode",        limit: 1,          null: false
    t.integer  "merchant_id",      limit: 4,          null: false
    t.integer  "portal_id",        limit: 4,          null: false
    t.datetime "creation_date",                       null: false
    t.text     "request_details",  limit: 4294967295, null: false
    t.text     "response_details", limit: 4294967295, null: false
  end

  create_table "s_plugin_mopt_payone_config", force: :cascade do |t|
    t.integer "payment_id",                       limit: 4,          null: false
    t.integer "merchant_id",                      limit: 4,          null: false
    t.integer "portal_id",                        limit: 4,          null: false
    t.integer "subaccount_id",                    limit: 4,          null: false
    t.string  "api_key",                          limit: 100,        null: false
    t.boolean "live_mode",                        limit: 1,          null: false
    t.string  "authorisation_method",             limit: 100,        null: false
    t.boolean "submit_basket",                    limit: 1,          null: false
    t.boolean "adresscheck_active",               limit: 1,          null: false
    t.boolean "adresscheck_live_mode",            limit: 1,          null: false
    t.integer "adresscheck_billing_adress",       limit: 4,          null: false
    t.integer "adresscheck_shipping_adress",      limit: 4,          null: false
    t.integer "adresscheck_automatic_correction", limit: 4,          null: false
    t.integer "adresscheck_failure_handling",     limit: 4,          null: false
    t.integer "adresscheck_min_basket",           limit: 4,          null: false
    t.integer "adresscheck_max_basket",           limit: 4,          null: false
    t.integer "adresscheck_lifetime",             limit: 4,          null: false
    t.string  "adresscheck_failure_message",      limit: 255,        null: false
    t.integer "map_person_check",                 limit: 4,          null: false
    t.integer "map_know_pre_lastname",            limit: 4,          null: false
    t.integer "map_know_lastname",                limit: 4,          null: false
    t.integer "map_not_known_pre_lastname",       limit: 4,          null: false
    t.integer "map_multi_name_to_adress",         limit: 4,          null: false
    t.integer "map_undeliverable",                limit: 4,          null: false
    t.integer "map_person_dead",                  limit: 4,          null: false
    t.integer "map_wrong_adress",                 limit: 4,          null: false
    t.boolean "consumerscore_active",             limit: 1,          null: false
    t.boolean "consumerscore_live_mode",          limit: 1,          null: false
    t.integer "consumerscore_check_moment",       limit: 4,          null: false
    t.string  "consumerscore_check_mode",         limit: 4,          null: false
    t.integer "consumerscore_default",            limit: 4,          null: false
    t.integer "consumerscore_lifetime",           limit: 4,          null: false
    t.integer "consumerscore_min_basket",         limit: 4,          null: false
    t.integer "consumerscore_max_basket",         limit: 4,          null: false
    t.integer "consumerscore_failure_handling",   limit: 4,          null: false
    t.string  "consumerscore_note_message",       limit: 255,        null: false
    t.boolean "consumerscore_note_active",        limit: 1,          null: false
    t.string  "consumerscore_agreement_message",  limit: 255,        null: false
    t.boolean "consumerscore_agreement_active",   limit: 1,          null: false
    t.integer "consumerscore_abtest_value",       limit: 4,          null: false
    t.boolean "consumerscore_abtest_active",      limit: 1,          null: false
    t.text    "payment_specific_data",            limit: 4294967295
    t.integer "state_appointed",                  limit: 4
    t.integer "state_capture",                    limit: 4
    t.integer "state_paid",                       limit: 4
    t.integer "state_underpaid",                  limit: 4
    t.integer "state_cancelation",                limit: 4
    t.integer "state_refund",                     limit: 4
    t.integer "state_debit",                      limit: 4
    t.integer "state_reminder",                   limit: 4
    t.integer "state_vauthorization",             limit: 4
    t.integer "state_vsettlement",                limit: 4
    t.integer "state_transfer",                   limit: 4
    t.integer "state_invoice",                    limit: 4
    t.boolean "check_cc",                         limit: 1,          null: false
    t.integer "check_account",                    limit: 4
    t.text    "trans_appointed",                  limit: 4294967295
    t.text    "trans_capture",                    limit: 4294967295
    t.text    "trans_paid",                       limit: 4294967295
    t.text    "trans_underpaid",                  limit: 4294967295
    t.text    "trans_cancelation",                limit: 4294967295
    t.text    "trans_refund",                     limit: 4294967295
    t.text    "trans_debit",                      limit: 4294967295
    t.text    "trans_reminder",                   limit: 4294967295
    t.text    "trans_vauthorization",             limit: 4294967295
    t.text    "trans_vsettlement",                limit: 4294967295
    t.text    "trans_transfer",                   limit: 4294967295
    t.text    "trans_invoice",                    limit: 4294967295
    t.boolean "show_accountnumber",               limit: 1,          null: false
    t.boolean "mandate_active",                   limit: 1,          null: false
    t.boolean "mandate_download_enabled",         limit: 1,          null: false
    t.string  "klarna_store_id",                  limit: 255
  end

  add_index "s_plugin_mopt_payone_config", ["payment_id"], name: "UNIQ_E1D4C4534C3A3BB", unique: true, using: :btree

  create_table "s_plugin_mopt_payone_payment_data", primary_key: "userId", force: :cascade do |t|
    t.text "moptPaymentData", limit: 65535, null: false
  end

  create_table "s_plugin_mopt_payone_transaction_log", force: :cascade do |t|
    t.integer  "transaction_id",   limit: 4,                         null: false
    t.integer  "order_nr",         limit: 4,                         null: false
    t.string   "status",           limit: 100,                       null: false
    t.datetime "transaction_date",                                   null: false
    t.integer  "sequence_nr",      limit: 4,                         null: false
    t.integer  "payment_id",       limit: 4,                         null: false
    t.boolean  "live_mode",        limit: 1,                         null: false
    t.integer  "portal_id",        limit: 4,                         null: false
    t.decimal  "claim",                               precision: 10, null: false
    t.decimal  "balance",                             precision: 10, null: false
    t.datetime "creation_date",                                      null: false
    t.datetime "update_date",                                        null: false
    t.text     "details",          limit: 4294967295,                null: false
  end

  create_table "s_plugin_recommendations", force: :cascade do |t|
    t.integer "categoryID",      limit: 4, null: false
    t.integer "banner_active",   limit: 4, null: false
    t.integer "new_active",      limit: 4, null: false
    t.integer "bought_active",   limit: 4, null: false
    t.integer "supplier_active", limit: 4, null: false
  end

  add_index "s_plugin_recommendations", ["categoryID"], name: "categoryID_2", unique: true, using: :btree

  create_table "s_plugin_swag_trusted_shops", primary_key: "shopId", force: :cascade do |t|
    t.string  "trustedShopsId",                    limit: 255
    t.string  "trustedShopsUser",                  limit: 255
    t.string  "trustedShopsPassword",              limit: 255
    t.boolean "trustedShopsTestSystem",            limit: 1
    t.boolean "trustedShopsShowRatingWidget",      limit: 1
    t.boolean "trustedShopsShowRatingsButtons",    limit: 1
    t.integer "trustedShopsRateLaterDays",         limit: 4
    t.string  "trustedShopsLanguageRatingButtons", limit: 255
    t.integer "trustedShopsWidthRatingButtons",    limit: 4
    t.text    "trustedShopsTrustBadgeCode",        limit: 4294967295
  end

  create_table "s_plugin_swag_trusted_shops_excellence_orders", force: :cascade do |t|
    t.string  "ordernumber",      limit: 30, null: false
    t.integer "shop_id",          limit: 4,  null: false
    t.string  "ts_applicationId", limit: 30, null: false
    t.integer "status",           limit: 4
  end

  create_table "s_plugin_widgets_notes", force: :cascade do |t|
    t.integer "userID", limit: 4,     null: false
    t.text    "notes",  limit: 65535, null: false
  end

  create_table "s_premium_dispatch", force: :cascade do |t|
    t.string  "name",                  limit: 255,                               null: false
    t.integer "type",                  limit: 4,                                 null: false
    t.text    "description",           limit: 16777215,                          null: false
    t.string  "comment",               limit: 255,                               null: false
    t.integer "active",                limit: 4,                                 null: false
    t.integer "position",              limit: 4,                                 null: false
    t.integer "calculation",           limit: 4,                                 null: false
    t.integer "surcharge_calculation", limit: 4,                                 null: false
    t.integer "tax_calculation",       limit: 4,                                 null: false
    t.decimal "shippingfree",                           precision: 10, scale: 2
    t.integer "multishopID",           limit: 4
    t.integer "customergroupID",       limit: 4
    t.integer "bind_shippingfree",     limit: 4,                                 null: false
    t.integer "bind_time_from",        limit: 4
    t.integer "bind_time_to",          limit: 4
    t.integer "bind_instock",          limit: 4
    t.integer "bind_laststock",        limit: 4,                                 null: false
    t.integer "bind_weekday_from",     limit: 4
    t.integer "bind_weekday_to",       limit: 4
    t.decimal "bind_weight_from",                       precision: 10, scale: 3
    t.decimal "bind_weight_to",                         precision: 10, scale: 3
    t.decimal "bind_price_from",                        precision: 10, scale: 2
    t.decimal "bind_price_to",                          precision: 10, scale: 2
    t.text    "bind_sql",              limit: 16777215
    t.text    "status_link",           limit: 16777215
    t.text    "calculation_sql",       limit: 16777215
  end

  create_table "s_premium_dispatch_attributes", force: :cascade do |t|
    t.integer "dispatchID", limit: 4
  end

  add_index "s_premium_dispatch_attributes", ["dispatchID"], name: "dispatchID", unique: true, using: :btree

  create_table "s_premium_dispatch_categories", id: false, force: :cascade do |t|
    t.integer "dispatchID", limit: 4, null: false
    t.integer "categoryID", limit: 4, null: false
  end

  create_table "s_premium_dispatch_countries", id: false, force: :cascade do |t|
    t.integer "dispatchID", limit: 4, null: false
    t.integer "countryID",  limit: 4, null: false
  end

  create_table "s_premium_dispatch_holidays", id: false, force: :cascade do |t|
    t.integer "dispatchID", limit: 4, null: false
    t.integer "holidayID",  limit: 4, null: false
  end

  create_table "s_premium_dispatch_paymentmeans", id: false, force: :cascade do |t|
    t.integer "dispatchID", limit: 4, null: false
    t.integer "paymentID",  limit: 4, null: false
  end

  create_table "s_premium_holidays", force: :cascade do |t|
    t.string "name",        limit: 255, null: false
    t.string "calculation", limit: 255, null: false
    t.date   "date",                    null: false
  end

  add_index "s_premium_holidays", ["date"], name: "date", using: :btree

  create_table "s_premium_shippingcosts", force: :cascade do |t|
    t.decimal "from",                 precision: 10, scale: 3, null: false
    t.decimal "value",                precision: 10, scale: 2, null: false
    t.decimal "factor",               precision: 10, scale: 2, null: false
    t.integer "dispatchID", limit: 4,                          null: false
  end

  add_index "s_premium_shippingcosts", ["from", "dispatchID"], name: "from", unique: true, using: :btree

  create_table "s_schema_version", primary_key: "version", force: :cascade do |t|
    t.datetime "start_date",                null: false
    t.datetime "complete_date"
    t.string   "name",          limit: 255, null: false
    t.string   "error_msg",     limit: 255
  end

  create_table "s_search_fields", force: :cascade do |t|
    t.string  "name",      limit: 255, null: false
    t.integer "relevance", limit: 4,   null: false
    t.string  "field",     limit: 255, null: false
    t.integer "tableID",   limit: 4,   null: false
  end

  add_index "s_search_fields", ["field", "tableID"], name: "field", unique: true, using: :btree
  add_index "s_search_fields", ["tableID"], name: "tableID", using: :btree

  create_table "s_search_index", id: false, force: :cascade do |t|
    t.integer "keywordID", limit: 4, null: false
    t.integer "fieldID",   limit: 4, null: false
    t.integer "elementID", limit: 4, null: false
  end

  add_index "s_search_index", ["keywordID", "fieldID"], name: "clean_up_index", using: :btree

  create_table "s_search_keywords", force: :cascade do |t|
    t.string "keyword", limit: 255, null: false
    t.string "soundex", limit: 255
  end

  add_index "s_search_keywords", ["keyword"], name: "keyword", unique: true, using: :btree
  add_index "s_search_keywords", ["soundex"], name: "soundex", using: :btree

  create_table "s_search_tables", force: :cascade do |t|
    t.string "table",          limit: 255, null: false
    t.string "referenz_table", limit: 255
    t.string "foreign_key",    limit: 255
    t.string "where",          limit: 255
  end

  create_table "s_statistics_article_impression", force: :cascade do |t|
    t.integer "articleId",   limit: 4, null: false
    t.integer "shopId",      limit: 4, null: false
    t.date    "date",                  null: false
    t.integer "impressions", limit: 4, null: false
  end

  add_index "s_statistics_article_impression", ["articleId", "shopId", "date"], name: "articleId_2", unique: true, using: :btree
  add_index "s_statistics_article_impression", ["articleId"], name: "articleId", using: :btree

  create_table "s_statistics_currentusers", force: :cascade do |t|
    t.string   "remoteaddr", limit: 255,             null: false
    t.string   "page",       limit: 70,              null: false
    t.datetime "time"
    t.integer  "userID",     limit: 4,   default: 0, null: false
  end

  create_table "s_statistics_pool", force: :cascade do |t|
    t.string "remoteaddr", limit: 255, null: false
    t.date   "datum",                  null: false
  end

  create_table "s_statistics_referer", force: :cascade do |t|
    t.date "datum",                    null: false
    t.text "referer", limit: 16777215, null: false
  end

  create_table "s_statistics_search", force: :cascade do |t|
    t.datetime "datum",                  null: false
    t.string   "searchterm", limit: 255, null: false
    t.integer  "results",    limit: 4,   null: false
  end

  add_index "s_statistics_search", ["searchterm"], name: "searchterm", using: :btree

  create_table "s_statistics_visitors", force: :cascade do |t|
    t.integer "shopID",          limit: 4,             null: false
    t.date    "datum",                                 null: false
    t.integer "pageimpressions", limit: 4, default: 0, null: false
    t.integer "uniquevisits",    limit: 4, default: 0, null: false
  end

  add_index "s_statistics_visitors", ["datum"], name: "datum", using: :btree

  create_table "s_user", force: :cascade do |t|
    t.string   "password",        limit: 255,                      null: false
    t.string   "encoder",         limit: 255,      default: "md5", null: false
    t.string   "email",           limit: 70,                       null: false
    t.integer  "active",          limit: 4,        default: 0,     null: false
    t.integer  "accountmode",     limit: 4,                        null: false
    t.string   "confirmationkey", limit: 100,                      null: false
    t.integer  "paymentID",       limit: 4,        default: 0,     null: false
    t.date     "firstlogin",                                       null: false
    t.datetime "lastlogin",                                        null: false
    t.string   "sessionID",       limit: 128
    t.integer  "newsletter",      limit: 4,        default: 0,     null: false
    t.string   "validation",      limit: 255,      default: "0",   null: false
    t.integer  "affiliate",       limit: 4,        default: 0,     null: false
    t.string   "customergroup",   limit: 15,                       null: false
    t.integer  "paymentpreset",   limit: 4,                        null: false
    t.string   "language",        limit: 10,                       null: false
    t.integer  "subshopID",       limit: 4,                        null: false
    t.string   "referer",         limit: 255,                      null: false
    t.integer  "pricegroupID",    limit: 4
    t.text     "internalcomment", limit: 16777215,                 null: false
    t.integer  "failedlogins",    limit: 4,                        null: false
    t.datetime "lockeduntil"
  end

  add_index "s_user", ["email"], name: "email", using: :btree
  add_index "s_user", ["firstlogin"], name: "firstlogin", using: :btree
  add_index "s_user", ["lastlogin"], name: "lastlogin", using: :btree
  add_index "s_user", ["pricegroupID"], name: "pricegroupID", using: :btree
  add_index "s_user", ["sessionID"], name: "sessionID", using: :btree

  create_table "s_user_attributes", force: :cascade do |t|
    t.integer "userID",            limit: 4
    t.string  "sofort_ideal_bank", limit: 255
  end

  add_index "s_user_attributes", ["userID"], name: "userID", unique: true, using: :btree

  create_table "s_user_billingaddress", force: :cascade do |t|
    t.integer "userID",         limit: 4,   default: 0, null: false
    t.string  "company",        limit: 255,             null: false
    t.string  "department",     limit: 35,              null: false
    t.string  "salutation",     limit: 30,              null: false
    t.string  "customernumber", limit: 30
    t.string  "firstname",      limit: 50,              null: false
    t.string  "lastname",       limit: 60,              null: false
    t.string  "street",         limit: 100,             null: false
    t.string  "streetnumber",   limit: 50,              null: false
    t.string  "zipcode",        limit: 50,              null: false
    t.string  "city",           limit: 70,              null: false
    t.string  "phone",          limit: 40,              null: false
    t.string  "fax",            limit: 40,              null: false
    t.integer "countryID",      limit: 4,   default: 0, null: false
    t.integer "stateID",        limit: 4
    t.string  "ustid",          limit: 50,              null: false
    t.date    "birthday"
  end

  add_index "s_user_billingaddress", ["userID"], name: "userID", unique: true, using: :btree

  create_table "s_user_billingaddress_attributes", force: :cascade do |t|
    t.integer "billingID", limit: 4
    t.string  "text1",     limit: 255
    t.string  "text2",     limit: 255
    t.string  "text3",     limit: 255
    t.string  "text4",     limit: 255
    t.string  "text5",     limit: 255
    t.string  "text6",     limit: 255
  end

  add_index "s_user_billingaddress_attributes", ["billingID"], name: "billingID", unique: true, using: :btree

  create_table "s_user_debit", force: :cascade do |t|
    t.integer "userID",     limit: 4,   default: 0, null: false
    t.string  "account",    limit: 30,              null: false
    t.string  "bankcode",   limit: 30,              null: false
    t.string  "bankname",   limit: 255,             null: false
    t.string  "bankholder", limit: 255,             null: false
  end

  create_table "s_user_shippingaddress", force: :cascade do |t|
    t.integer "userID",       limit: 4,   default: 0, null: false
    t.string  "company",      limit: 255,             null: false
    t.string  "department",   limit: 35,              null: false
    t.string  "salutation",   limit: 30,              null: false
    t.string  "firstname",    limit: 50,              null: false
    t.string  "lastname",     limit: 60,              null: false
    t.string  "street",       limit: 100,             null: false
    t.string  "streetnumber", limit: 50,              null: false
    t.string  "zipcode",      limit: 50,              null: false
    t.string  "city",         limit: 70,              null: false
    t.integer "countryID",    limit: 4
    t.integer "stateID",      limit: 4
  end

  add_index "s_user_shippingaddress", ["userID"], name: "userID", unique: true, using: :btree

  create_table "s_user_shippingaddress_attributes", force: :cascade do |t|
    t.integer "shippingID", limit: 4
    t.string  "text1",      limit: 255
    t.string  "text2",      limit: 255
    t.string  "text3",      limit: 255
    t.string  "text4",      limit: 255
    t.string  "text5",      limit: 255
    t.string  "text6",      limit: 255
  end

  add_index "s_user_shippingaddress_attributes", ["shippingID"], name: "shippingID", unique: true, using: :btree

  create_table "scopes", force: :cascade do |t|
    t.string   "country_code",     limit: 255
    t.string   "locale",           limit: 255
    t.string   "language",         limit: 255
    t.string   "region_code",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",        limit: 1,     default: false
    t.string   "facebook",         limit: 255
    t.string   "twitter",          limit: 255
    t.string   "google",           limit: 255
    t.string   "pinterest",        limit: 255
    t.string   "instagram",        limit: 255
    t.string   "youtube",          limit: 255
    t.text     "hidden",           limit: 65535
    t.string   "meta_keywords",    limit: 255
    t.text     "meta_description", limit: 65535
  end

  add_index "scopes", ["country_code"], name: "index_scopes_on_country_code", length: {"country_code"=>10}, using: :btree
  add_index "scopes", ["locale"], name: "index_scopes_on_locale", length: {"locale"=>10}, using: :btree
  add_index "scopes", ["published"], name: "index_scopes_on_published", using: :btree

  create_table "shops", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "logo",           limit: 255
    t.text     "link",           limit: 65535
    t.text     "body",           limit: 65535
    t.text     "sidebar_banner", limit: 65535
    t.text     "top_banner",     limit: 65535
    t.text     "bottom_banner",  limit: 65535
    t.integer  "scope_id",       limit: 4
    t.integer  "position",       limit: 4,     default: 0
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "favorite",       limit: 1
  end

  add_index "shops", ["favorite"], name: "index_shops_on_favorite", using: :btree
  add_index "shops", ["position"], name: "index_shops_on_position", using: :btree
  add_index "shops", ["scope_id"], name: "index_shops_on_scope_id", using: :btree

  create_table "simple_hashtag_hashtaggings", force: :cascade do |t|
    t.integer "hashtag_id",        limit: 4
    t.integer "hashtaggable_id",   limit: 4
    t.string  "hashtaggable_type", limit: 255
  end

  add_index "simple_hashtag_hashtaggings", ["hashtag_id"], name: "index_simple_hashtag_hashtaggings_on_hashtag_id", using: :btree
  add_index "simple_hashtag_hashtaggings", ["hashtaggable_id", "hashtaggable_type"], name: "index_hashtaggings_hashtaggable_id_hashtaggable_type", using: :btree

  create_table "simple_hashtag_hashtags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "scope_id",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_hashtag_hashtags", ["name", "scope_id"], name: "index_simple_hashtag_hashtags_on_name_and_scope_id", unique: true, using: :btree

  create_table "sofort_config_data", id: false, force: :cascade do |t|
    t.integer "id",                                              limit: 4,                            null: false
    t.string  "option_general_reason_one",                       limit: 255, default: "{{order_id}}"
    t.string  "option_general_reason_two",                       limit: 255, default: ""
    t.boolean "option_general_logging",                          limit: 1,   default: false
    t.boolean "option_general_create_transactions",              limit: 1,   default: true
    t.boolean "option_sofortbanking_frontend_display",           limit: 1,   default: true
    t.string  "option_sofortbanking_key",                        limit: 255, default: ""
    t.boolean "option_sofortbanking_customer_protection",        limit: 1,   default: false
    t.boolean "option_sofortbanking_recommended_payment",        limit: 1,   default: true
    t.boolean "option_sofortbanking_state_temporary",            limit: 1,   default: false
    t.boolean "option_sofortbanking_state_payment_confirmed",    limit: 1,   default: false
    t.boolean "option_sofortbanking_state_payment_received",     limit: 1,   default: false
    t.boolean "option_sofortbanking_state_payment_canceled",     limit: 1,   default: false
    t.boolean "option_sofortbanking_state_investigation_needed", limit: 1,   default: false
    t.boolean "option_sofortbanking_state_refund_partial",       limit: 1,   default: false
    t.boolean "option_sofortbanking_state_refund_full",          limit: 1,   default: false
    t.boolean "option_ideal_frontend_display",                   limit: 1,   default: true
    t.string  "option_ideal_key",                                limit: 255, default: ""
    t.string  "option_ideal_project_password",                   limit: 255, default: ""
    t.string  "option_ideal_notification_password",              limit: 255, default: ""
    t.boolean "option_ideal_recommended_payment",                limit: 1,   default: true
    t.boolean "option_ideal_state_temporary",                    limit: 1,   default: false
    t.boolean "option_ideal_state_payment_pending",              limit: 1,   default: false
    t.boolean "option_ideal_state_payment_received",             limit: 1,   default: false
    t.boolean "option_ideal_state_payment_canceled",             limit: 1,   default: false
    t.boolean "option_ideal_state_storno",                       limit: 1,   default: false
    t.boolean "option_ideal_state_refund_partial",               limit: 1,   default: false
    t.boolean "option_ideal_state_refund_full",                  limit: 1,   default: false
  end

  add_index "sofort_config_data", ["id"], name: "id", unique: true, using: :btree

  create_table "sofort_payment_basket", force: :cascade do |t|
    t.string   "sessionID",               limit: 70,                     null: false
    t.integer  "userID",                  limit: 4,        default: 0,   null: false
    t.string   "articlename",             limit: 255,                    null: false
    t.integer  "articleID",               limit: 4,        default: 0,   null: false
    t.string   "ordernumber",             limit: 30,                     null: false
    t.integer  "shippingfree",            limit: 4,        default: 0,   null: false
    t.integer  "quantity",                limit: 4,        default: 0,   null: false
    t.float    "price",                   limit: 53,       default: 0.0, null: false
    t.float    "netprice",                limit: 53,       default: 0.0, null: false
    t.float    "tax_rate",                limit: 53,                     null: false
    t.datetime "datum",                                                  null: false
    t.integer  "modus",                   limit: 4,        default: 0,   null: false
    t.integer  "esdarticle",              limit: 4,                      null: false
    t.string   "partnerID",               limit: 45,                     null: false
    t.string   "lastviewport",            limit: 255,                    null: false
    t.string   "useragent",               limit: 255,                    null: false
    t.text     "config",                  limit: 16777215,               null: false
    t.float    "currencyFactor",          limit: 53,                     null: false
    t.integer  "liveshoppingID",          limit: 4,                      null: false
    t.integer  "bundleID",                limit: 4,                      null: false
    t.string   "bundle_join_ordernumber", limit: 255,                    null: false
  end

  create_table "sofort_payment_log", force: :cascade do |t|
    t.datetime "entry_date",                   null: false
    t.string   "version_module", limit: 25,    null: false
    t.string   "source",         limit: 250,   null: false
    t.text     "message",        limit: 65535, null: false
  end

  create_table "synonyms", force: :cascade do |t|
  end

  create_table "synonyms_words", force: :cascade do |t|
    t.integer "synonym_id", limit: 4
    t.integer "word_id",    limit: 4
  end

  add_index "synonyms_words", ["synonym_id"], name: "index_synonyms_words_on_synonym_id", using: :btree
  add_index "synonyms_words", ["word_id"], name: "index_synonyms_words_on_word_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "user_authentications", force: :cascade do |t|
    t.integer  "user_id",                    limit: 4
    t.integer  "authentication_provider_id", limit: 4
    t.string   "uid",                        limit: 255
    t.string   "token",                      limit: 255
    t.datetime "token_expires_at"
    t.text     "params",                     limit: 65535
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "user_authentications", ["authentication_provider_id"], name: "index_user_authentications_on_authentication_provider_id", using: :btree
  add_index "user_authentications", ["user_id"], name: "index_user_authentications_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                                limit: 255,   default: "",     null: false
    t.string   "name",                                 limit: 255
    t.string   "avatar",                               limit: 255
    t.string   "role",                                 limit: 255,   default: "user"
    t.string   "slug",                                 limit: 255
    t.string   "encrypted_password",                   limit: 255,   default: "",     null: false
    t.string   "reset_password_token",                 limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        limit: 4,     default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",                   limit: 255
    t.string   "last_sign_in_ip",                      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token",                   limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",                    limit: 255
    t.string   "secret",                               limit: 255
    t.string   "banner",                               limit: 255
    t.text     "info",                                 limit: 65535
    t.integer  "fashion_fly_editor_collections_count", limit: 4,     default: 0
    t.integer  "favorites_count",                      limit: 4,     default: 0
    t.integer  "five_star_rates_count",                limit: 4,     default: 0
    t.integer  "visitors",                             limit: 4,     default: 0
    t.integer  "max_single_collection_share",          limit: 4,     default: 0
    t.integer  "visits_count",                         limit: 4,     default: 0
    t.integer  "scope_id",                             limit: 4
    t.string   "blog_status",                          limit: 255,   default: "NONE"
    t.boolean  "is_blogger",                           limit: 1,     default: false
    t.string   "blog_title",                           limit: 255
    t.text     "blog_feed",                            limit: 65535
    t.string   "blog_url",                             limit: 255
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["is_blogger"], name: "index_users_on_is_blogger", using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role"], name: "index_users_on_role", using: :btree
  add_index "users", ["scope_id"], name: "index_users_on_scope_id", using: :btree
  add_index "users", ["secret"], name: "index_users_on_secret", using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree

  create_table "visits", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.string   "cookie",         limit: 255
    t.integer  "visitable_id",   limit: 4
    t.string   "visitable_type", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "visits", ["cookie"], name: "index_visits_on_cookie", using: :btree
  add_index "visits", ["user_id", "cookie", "visitable_id", "visitable_type"], name: "visitings", unique: true, using: :btree
  add_index "visits", ["user_id"], name: "index_visits_on_user_id", using: :btree
  add_index "visits", ["visitable_id", "visitable_type"], name: "index_visits_on_visitable_id_and_visitable_type", using: :btree

  create_table "words", force: :cascade do |t|
    t.integer "scope_id", limit: 4
    t.string  "value",    limit: 255
    t.string  "type",     limit: 255
  end

  add_index "words", ["scope_id"], name: "index_words_on_scope_id", using: :btree
  add_index "words", ["type"], name: "index_words_on_type", using: :btree

  add_foreign_key "s_article_configurator_template_prices_attributes", "s_article_configurator_template_prices", column: "template_price_id", name: "s_article_configurator_template_prices_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_article_configurator_templates_attributes", "s_article_configurator_templates", column: "template_id", name: "s_article_configurator_templates_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_articles_attributes", "s_articles", column: "articleID", name: "s_articles_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_articles_attributes", "s_articles_details", column: "articledetailsID", name: "s_articles_attributes_ibfk_2", on_delete: :cascade
  add_foreign_key "s_articles_downloads_attributes", "s_articles_downloads", column: "downloadID", name: "s_articles_downloads_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_articles_esd_attributes", "s_articles_esd", column: "esdID", name: "s_articles_esd_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_articles_img_attributes", "s_articles_img", column: "imageID", name: "s_articles_img_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_articles_information_attributes", "s_articles_information", column: "informationID", name: "s_articles_information_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_articles_prices_attributes", "s_articles_prices", column: "priceID", name: "s_articles_prices_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_articles_supplier_attributes", "s_articles_supplier", column: "supplierID", name: "s_articles_supplier_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_blog_attributes", "s_blog", column: "blog_id", name: "s_blog_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_categories_attributes", "s_categories", column: "categoryID", name: "s_categories_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_cms_static_attributes", "s_cms_static", column: "cmsStaticID", name: "s_cms_static_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_cms_support_attributes", "s_cms_support", column: "cmsSupportID", name: "s_cms_support_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_core_auth_attributes", "s_core_auth", column: "authID", name: "s_core_auth_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_core_config_mails", "s_core_states", column: "stateId", name: "s_core_config_mails_ibfk_1"
  add_foreign_key "s_core_config_mails_attributes", "s_core_config_mails", column: "mailID", name: "s_core_config_mails_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_core_countries_attributes", "s_core_countries", column: "countryID", name: "s_core_countries_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_core_countries_states_attributes", "s_core_countries_states", column: "stateID", name: "s_core_countries_states_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_core_customergroups_attributes", "s_core_customergroups", column: "customerGroupID", name: "s_core_customergroups_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_core_paymentmeans_attributes", "s_core_paymentmeans", column: "paymentmeanID", name: "s_core_paymentmeans_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_emarketing_banners_attributes", "s_emarketing_banners", column: "bannerID", name: "s_emarketing_banners_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_emarketing_vouchers_attributes", "s_emarketing_vouchers", column: "voucherID", name: "s_emarketing_vouchers_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_emotion_attributes", "s_emotion", column: "emotionID", name: "s_emotion_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_export_attributes", "s_export", column: "exportID", name: "s_export_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_filter_attributes", "s_filter", column: "filterID", name: "s_filter_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_media_attributes", "s_media", column: "mediaID", name: "s_media_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_order_attributes", "s_order", column: "orderID", name: "s_order_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_order_basket_attributes", "s_order_basket", column: "basketID", name: "s_order_basket_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_order_billingaddress_attributes", "s_order_billingaddress", column: "billingID", name: "s_order_billingaddress_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_order_details_attributes", "s_order_details", column: "detailID", name: "s_order_details_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_order_documents_attributes", "s_order_documents", column: "documentID", primary_key: "ID", name: "s_order_documents_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_order_shippingaddress_attributes", "s_order_shippingaddress", column: "shippingID", name: "s_order_shippingaddress_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_premium_dispatch_attributes", "s_premium_dispatch", column: "dispatchID", name: "s_premium_dispatch_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_user_attributes", "s_user", column: "userID", name: "s_user_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_user_billingaddress_attributes", "s_user_billingaddress", column: "billingID", name: "s_user_billingaddress_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "s_user_shippingaddress_attributes", "s_user_shippingaddress", column: "shippingID", name: "s_user_shippingaddress_attributes_ibfk_1", on_delete: :cascade
end
