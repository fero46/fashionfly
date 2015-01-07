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

ActiveRecord::Schema.define(version: 20150107150902) do

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

  create_table "brands", force: :cascade do |t|
    t.string "name", limit: 255
  end

  add_index "brands", ["name"], name: "index_brands_on_name", using: :btree

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
    t.string   "description",     limit: 255
    t.string   "image",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id",     limit: 4
    t.integer  "user_id",         limit: 4
    t.integer  "actual_trend",    limit: 4
    t.integer  "last_trend",      limit: 4
    t.integer  "favorites_count", limit: 4
    t.boolean  "published",       limit: 1,   default: false
    t.integer  "visits_count",    limit: 4,   default: 0
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
  end

  add_index "products", ["actual_trend"], name: "index_products_on_actual_trend", using: :btree
  add_index "products", ["affiliate_id", "affi_code", "scope_id"], name: "index_products_on_affiliate_id_and_affi_code_and_scope_id", unique: true, using: :btree
  add_index "products", ["affiliate_id"], name: "index_products_on_affiliate_id", using: :btree
  add_index "products", ["brand_id"], name: "index_products_on_brand_id", using: :btree
  add_index "products", ["colorization_id"], name: "index_products_on_colorization_id", using: :btree
  add_index "products", ["favorites_count"], name: "index_products_on_favorites_count", using: :btree
  add_index "products", ["premium"], name: "index_products_on_premium", using: :btree
  add_index "products", ["published"], name: "index_products_on_published", using: :btree
  add_index "products", ["random_order"], name: "index_products_on_random_order", using: :btree
  add_index "products", ["scope_id"], name: "index_products_on_scope_id", using: :btree

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

  create_table "scopes", force: :cascade do |t|
    t.string   "country_code", limit: 255
    t.string   "locale",       limit: 255
    t.string   "language",     limit: 255
    t.string   "region_code",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",    limit: 1,     default: false
    t.string   "facebook",     limit: 255
    t.string   "twitter",      limit: 255
    t.string   "google",       limit: 255
    t.string   "pinterest",    limit: 255
    t.string   "instagram",    limit: 255
    t.string   "youtube",      limit: 255
    t.text     "hidden",       limit: 65535
  end

  add_index "scopes", ["country_code"], name: "index_scopes_on_country_code", length: {"country_code"=>10}, using: :btree
  add_index "scopes", ["locale"], name: "index_scopes_on_locale", length: {"locale"=>10}, using: :btree
  add_index "scopes", ["published"], name: "index_scopes_on_published", using: :btree

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

  create_table "synonyms", force: :cascade do |t|
  end

  create_table "synonyms_words", force: :cascade do |t|
    t.integer "synonym_id", limit: 4
    t.integer "word_id",    limit: 4
  end

  add_index "synonyms_words", ["synonym_id"], name: "index_synonyms_words_on_synonym_id", using: :btree
  add_index "synonyms_words", ["word_id"], name: "index_synonyms_words_on_word_id", using: :btree

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
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role"], name: "index_users_on_role", using: :btree
  add_index "users", ["secret"], name: "index_users_on_secret", using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree

  create_table "words", force: :cascade do |t|
    t.integer "scope_id", limit: 4
    t.string  "value",    limit: 255
    t.string  "type",     limit: 255
  end

  add_index "words", ["scope_id"], name: "index_words_on_scope_id", using: :btree
  add_index "words", ["type"], name: "index_words_on_type", using: :btree

end
