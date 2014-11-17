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

ActiveRecord::Schema.define(version: 20141117174031) do

  create_table "affiliates", force: true do |t|
    t.string   "file"
    t.string   "name"
    t.boolean  "ready"
    t.integer  "scope_id"
    t.string   "item_tag"
    t.string   "category_tag"
    t.string   "category_split_char"
    t.string   "ean_tag"
    t.string   "image_tag"
    t.string   "name_tag"
    t.string   "number_tag"
    t.string   "description_tag"
    t.string   "brand_tag"
    t.string   "price_tag"
    t.string   "shipping_cost_tag"
    t.string   "last_modified_tag"
    t.string   "delivery_time_tag"
    t.string   "currency_code_tag"
    t.string   "link_tag"
    t.string   "importer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "importing",           default: false
    t.integer  "percent",             default: 0
    t.string   "logo"
    t.boolean  "free_shipping",       default: false
    t.boolean  "pay_invoice",         default: false
    t.boolean  "premium",             default: false
  end

  add_index "affiliates", ["importing"], name: "index_affiliates_on_importing", using: :btree
  add_index "affiliates", ["scope_id"], name: "index_affiliates_on_scope_id", using: :btree

  create_table "authentication_providers", force: true do |t|
    t.string   "name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "position",   default: 0
  end

  add_index "authentication_providers", ["name"], name: "index_name_on_authentication_providers", using: :btree
  add_index "authentication_providers", ["position"], name: "index_authentication_providers_on_position", using: :btree

  create_table "average_caches", force: true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "avg",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "scope_id"
    t.boolean  "main_taxon"
    t.integer  "position"
    t.boolean  "published",   default: false
    t.boolean  "leaf"
  end

  add_index "categories", ["category_id"], name: "index_categories_on_category_id", using: :btree
  add_index "categories", ["leaf"], name: "index_categories_on_leaf", using: :btree
  add_index "categories", ["main_taxon"], name: "index_categories_on_main_taxon", using: :btree
  add_index "categories", ["position"], name: "index_categories_on_position", using: :btree
  add_index "categories", ["published"], name: "index_categories_on_published", using: :btree
  add_index "categories", ["scope_id"], name: "index_categories_on_scope_id", using: :btree
  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree

  create_table "categories_icons", force: true do |t|
    t.integer "category_id"
    t.integer "icon_id"
  end

  add_index "categories_icons", ["category_id"], name: "index_categories_icons_on_category_id", using: :btree
  add_index "categories_icons", ["icon_id"], name: "index_categories_icons_on_icon_id", using: :btree

  create_table "categorizations", force: true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categorizations", ["category_id", "product_id"], name: "index_categorizations_on_category_id_and_product_id", using: :btree
  add_index "categorizations", ["category_id"], name: "index_categorizations_on_category_id", using: :btree
  add_index "categorizations", ["product_id"], name: "index_categorizations_on_product_id", using: :btree

  create_table "color_words", force: true do |t|
    t.integer "scope_id"
    t.integer "colorization_id"
    t.string  "sentence_part"
    t.string  "descriptive"
  end

  add_index "color_words", ["colorization_id"], name: "index_color_words_on_colorization_id", using: :btree
  add_index "color_words", ["scope_id"], name: "index_color_words_on_scope_id", using: :btree

  create_table "colorizations", force: true do |t|
    t.string "name"
  end

  add_index "colorizations", ["name"], name: "index_colorizations_on_name", using: :btree

  create_table "colorizations_words", force: true do |t|
    t.integer "colorization_id"
    t.integer "word_id"
  end

  add_index "colorizations_words", ["colorization_id"], name: "index_colorizations_words_on_colorization_id", using: :btree
  add_index "colorizations_words", ["word_id"], name: "index_colorizations_words_on_word_id", using: :btree

  create_table "configurations", force: true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "configurations", ["key"], name: "index_configurations_on_key", unique: true, using: :btree

  create_table "contests", force: true do |t|
    t.string   "title"
    t.string   "banner"
    t.string   "slug"
    t.text     "body"
    t.integer  "scope_id"
    t.boolean  "finished"
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

  create_table "fashion_fly_editor_categories", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "parent_id"
    t.string   "parent_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "scope_id"
  end

  add_index "fashion_fly_editor_categories", ["parent_id", "parent_type"], name: "category_parent", using: :btree
  add_index "fashion_fly_editor_categories", ["scope_id"], name: "index_fashion_fly_editor_categories_on_scope_id", using: :btree
  add_index "fashion_fly_editor_categories", ["slug"], name: "index_fashion_fly_editor_categories_on_slug", unique: true, using: :btree

  create_table "fashion_fly_editor_collection_items", force: true do |t|
    t.integer  "collection_id"
    t.integer  "item_id"
    t.integer  "position_x"
    t.integer  "position_y"
    t.float    "width"
    t.float    "height"
    t.float    "rotation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "fashion_fly_editor_collections", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.integer  "user_id"
    t.integer  "actual_trend"
    t.integer  "last_trend"
    t.integer  "favorites_count"
    t.boolean  "published",       default: false
  end

  add_index "fashion_fly_editor_collections", ["actual_trend"], name: "index_fashion_fly_editor_collections_on_actual_trend", using: :btree
  add_index "fashion_fly_editor_collections", ["category_id"], name: "index_fashion_fly_editor_collections_on_category_id", using: :btree
  add_index "fashion_fly_editor_collections", ["favorites_count"], name: "index_fashion_fly_editor_collections_on_favorites_count", using: :btree
  add_index "fashion_fly_editor_collections", ["published"], name: "index_fashion_fly_editor_collections_on_published", using: :btree
  add_index "fashion_fly_editor_collections", ["user_id"], name: "index_fashion_fly_editor_collections_on_user_id", using: :btree

  create_table "fashion_fly_editor_subscriptions", force: true do |t|
    t.integer  "collection_id"
    t.integer  "subscriber_id"
    t.string   "subscriber_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fashion_fly_editor_subscriptions", ["collection_id"], name: "index_fashion_fly_editor_subscriptions_on_collection_id", using: :btree
  add_index "fashion_fly_editor_subscriptions", ["subscriber_id", "subscriber_type"], name: "subscriber", using: :btree

  create_table "favorites", force: true do |t|
    t.integer  "markable_id"
    t.string   "markable_type"
    t.integer  "user_id"
    t.string   "cookie_store"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["cookie_store"], name: "index_favorites_on_cookie_store", length: {"cookie_store"=>30}, using: :btree
  add_index "favorites", ["created_at"], name: "index_favorites_on_created_at", using: :btree
  add_index "favorites", ["markable_id", "markable_type"], name: "index_favorites_on_markable_id_and_markable_type", using: :btree
  add_index "favorites", ["markable_id"], name: "index_favorites_on_markable_id", using: :btree
  add_index "favorites", ["markable_type"], name: "index_favorites_on_markable_type", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "icons", force: true do |t|
    t.string "name"
    t.string "image"
  end

  add_index "icons", ["name"], name: "index_icons_on_name", using: :btree

  create_table "lit_incomming_localizations", force: true do |t|
    t.text     "translated_value"
    t.integer  "locale_id"
    t.integer  "localization_key_id"
    t.integer  "localization_id"
    t.string   "locale_str"
    t.string   "localization_key_str"
    t.integer  "source_id"
    t.integer  "incomming_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lit_incomming_localizations", ["incomming_id"], name: "index_lit_incomming_localizations_on_incomming_id", using: :btree
  add_index "lit_incomming_localizations", ["locale_id"], name: "index_lit_incomming_localizations_on_locale_id", using: :btree
  add_index "lit_incomming_localizations", ["localization_id"], name: "index_lit_incomming_localizations_on_localization_id", using: :btree
  add_index "lit_incomming_localizations", ["localization_key_id"], name: "index_lit_incomming_localizations_on_localization_key_id", using: :btree
  add_index "lit_incomming_localizations", ["source_id"], name: "index_lit_incomming_localizations_on_source_id", using: :btree

  create_table "lit_locales", force: true do |t|
    t.string   "locale"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_hidden",  default: false
  end

  create_table "lit_localization_keys", force: true do |t|
    t.string   "localization_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_completed",     default: false
    t.boolean  "is_starred",       default: false
  end

  add_index "lit_localization_keys", ["localization_key"], name: "index_lit_localization_keys_on_localization_key", unique: true, using: :btree

  create_table "lit_localization_versions", force: true do |t|
    t.text     "translated_value"
    t.integer  "localization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lit_localization_versions", ["localization_id"], name: "index_lit_localization_versions_on_localization_id", using: :btree

  create_table "lit_localizations", force: true do |t|
    t.integer  "locale_id"
    t.integer  "localization_key_id"
    t.text     "default_value"
    t.text     "translated_value"
    t.boolean  "is_changed",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lit_localizations", ["locale_id"], name: "index_lit_localizations_on_locale_id", using: :btree
  add_index "lit_localizations", ["localization_key_id"], name: "index_lit_localizations_on_localization_key_id", using: :btree

  create_table "lit_sources", force: true do |t|
    t.string   "identifier"
    t.string   "url"
    t.string   "api_key"
    t.datetime "last_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mappings", force: true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "affiliate_id"
  end

  add_index "mappings", ["affiliate_id"], name: "index_mappings_on_affiliate_id", using: :btree
  add_index "mappings", ["category_id"], name: "index_mappings_on_category_id", using: :btree
  add_index "mappings", ["name"], name: "index_mappings_on_name", using: :btree

  create_table "overall_averages", force: true do |t|
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "overall_avg",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
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
    t.integer  "scope_id"
    t.boolean  "published",                                     default: false
    t.integer  "actual_trend",                                  default: 0
    t.integer  "last_trend",                                    default: 0
    t.integer  "favorites_count",                               default: 0
    t.integer  "affiliate_id"
    t.boolean  "premium",                                       default: false
  end

  add_index "products", ["actual_trend"], name: "index_products_on_actual_trend", using: :btree
  add_index "products", ["affiliate_id", "affi_code", "scope_id"], name: "index_products_on_affiliate_id_and_affi_code_and_scope_id", unique: true, using: :btree
  add_index "products", ["affiliate_id"], name: "index_products_on_affiliate_id", using: :btree
  add_index "products", ["brand_id"], name: "index_products_on_brand_id", using: :btree
  add_index "products", ["colorization_id"], name: "index_products_on_colorization_id", using: :btree
  add_index "products", ["favorites_count"], name: "index_products_on_favorites_count", using: :btree
  add_index "products", ["premium"], name: "index_products_on_premium", using: :btree
  add_index "products", ["published"], name: "index_products_on_published", using: :btree
  add_index "products", ["scope_id"], name: "index_products_on_scope_id", using: :btree

  create_table "rates", force: true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: true do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "scopes", force: true do |t|
    t.string   "country_code"
    t.string   "locale"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",    default: false
  end

  add_index "scopes", ["country_code"], name: "index_scopes_on_country_code", length: {"country_code"=>10}, using: :btree
  add_index "scopes", ["locale"], name: "index_scopes_on_locale", length: {"locale"=>10}, using: :btree
  add_index "scopes", ["published"], name: "index_scopes_on_published", using: :btree

  create_table "synonyms", force: true do |t|
  end

  create_table "synonyms_words", force: true do |t|
    t.integer "synonym_id"
    t.integer "word_id"
  end

  add_index "synonyms_words", ["synonym_id"], name: "index_synonyms_words_on_synonym_id", using: :btree
  add_index "synonyms_words", ["word_id"], name: "index_synonyms_words_on_word_id", using: :btree

  create_table "user_authentications", force: true do |t|
    t.integer  "user_id"
    t.integer  "authentication_provider_id"
    t.string   "uid"
    t.string   "token"
    t.datetime "token_expires_at"
    t.text     "params"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "user_authentications", ["authentication_provider_id"], name: "index_user_authentications_on_authentication_provider_id", using: :btree
  add_index "user_authentications", ["user_id"], name: "index_user_authentications_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "name"
    t.string   "avatar"
    t.string   "role",                   default: "user"
    t.string   "slug"
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "secret"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role"], name: "index_users_on_role", using: :btree
  add_index "users", ["secret"], name: "index_users_on_secret", using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree

  create_table "words", force: true do |t|
    t.integer "scope_id"
    t.string  "value"
    t.string  "type"
  end

  add_index "words", ["scope_id"], name: "index_words_on_scope_id", using: :btree
  add_index "words", ["type"], name: "index_words_on_type", using: :btree

end
