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

ActiveRecord::Schema.define(version: 20181129103819) do

  create_table "affiliates", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "file"
    t.string "name"
    t.boolean "ready"
    t.integer "scope_id"
    t.string "item_tag"
    t.string "category_tag"
    t.string "category_split_char"
    t.string "ean_tag"
    t.string "image_tag"
    t.string "name_tag"
    t.string "number_tag"
    t.string "description_tag"
    t.string "brand_tag"
    t.string "price_tag"
    t.string "shipping_cost_tag"
    t.string "last_modified_tag"
    t.string "delivery_time_tag"
    t.string "currency_code_tag"
    t.string "link_tag"
    t.string "importer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "importing", default: false
    t.integer "percent", default: 0
    t.string "logo"
    t.boolean "free_shipping", default: false
    t.boolean "pay_invoice", default: false
    t.boolean "premium", default: false
    t.boolean "replace_only_images", default: false
    t.integer "start_from_id", default: 0
    t.integer "skip_items", default: 0
    t.string "board_number"
    t.index ["importing"], name: "index_affiliates_on_importing"
    t.index ["scope_id"], name: "index_affiliates_on_scope_id"
  end

  create_table "authentication_providers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 0
    t.index ["name"], name: "index_name_on_authentication_providers"
    t.index ["position"], name: "index_authentication_providers_on_position"
  end

  create_table "average_caches", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "rater_id"
    t.string "rateable_type"
    t.integer "rateable_id"
    t.float "avg", limit: 24, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banners", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "name"
    t.string "banner"
    t.text "link"
    t.string "preview_ids"
    t.string "previews_model"
    t.integer "scope_id"
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position"], name: "index_banners_on_position"
    t.index ["scope_id"], name: "index_banners_on_scope_id"
  end

  create_table "brands", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "name"
    t.string "slug"
    t.index ["name"], name: "index_brands_on_name"
    t.index ["slug"], name: "index_brands_on_slug"
  end

  create_table "brands_categories", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "brand_id"
    t.integer "category_id"
    t.index ["brand_id", "category_id"], name: "by_brand_category", unique: true
    t.index ["brand_id"], name: "index_brands_categories_on_brand_id"
    t.index ["category_id"], name: "index_brands_categories_on_category_id"
  end

  create_table "categories", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "name"
    t.integer "category_id"
    t.string "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "scope_id"
    t.boolean "main_taxon"
    t.integer "position"
    t.boolean "published", default: false
    t.boolean "leaf"
    t.index ["category_id"], name: "index_categories_on_category_id"
    t.index ["leaf"], name: "index_categories_on_leaf"
    t.index ["main_taxon"], name: "index_categories_on_main_taxon"
    t.index ["position"], name: "index_categories_on_position"
    t.index ["published"], name: "index_categories_on_published"
    t.index ["scope_id"], name: "index_categories_on_scope_id"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "categories_icons", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "category_id"
    t.integer "icon_id"
    t.index ["category_id"], name: "index_categories_icons_on_category_id"
    t.index ["icon_id"], name: "index_categories_icons_on_icon_id"
  end

  create_table "categorizations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "product_id"
    t.integer "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category_id", "product_id"], name: "index_categorizations_on_category_id_and_product_id"
    t.index ["category_id"], name: "index_categorizations_on_category_id"
    t.index ["product_id"], name: "index_categorizations_on_product_id"
  end

  create_table "color_words", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "scope_id"
    t.integer "colorization_id"
    t.string "sentence_part"
    t.string "descriptive"
    t.index ["colorization_id"], name: "index_color_words_on_colorization_id"
    t.index ["scope_id"], name: "index_color_words_on_scope_id"
  end

  create_table "colorizations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "name"
    t.string "word"
    t.string "oposite_color"
    t.index ["name"], name: "index_colorizations_on_name"
  end

  create_table "colorizations_words", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "colorization_id"
    t.integer "word_id"
    t.index ["colorization_id"], name: "index_colorizations_words_on_colorization_id"
    t.index ["word_id"], name: "index_colorizations_words_on_word_id"
  end

  create_table "comments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "title", limit: 50, default: ""
    t.text "comment"
    t.string "commentable_type"
    t.integer "commentable_id"
    t.integer "user_id"
    t.string "role", default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
    t.index ["commentable_type"], name: "index_comments_on_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "configurations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["key"], name: "index_configurations_on_key", unique: true
  end

  create_table "contests", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "title"
    t.string "banner"
    t.string "slug"
    t.text "body"
    t.integer "scope_id"
    t.boolean "finished"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "startdate"
    t.date "enddate"
    t.index ["enddate"], name: "index_contests_on_enddate"
    t.index ["finished"], name: "index_contests_on_finished"
    t.index ["scope_id"], name: "index_contests_on_scope_id"
    t.index ["slug"], name: "index_contests_on_slug"
    t.index ["startdate"], name: "index_contests_on_startdate"
  end

  create_table "entries", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "title"
    t.text "url"
    t.date "published"
    t.string "author"
    t.string "entry_identifier"
    t.binary "summary", limit: 16777215
    t.binary "content", limit: 16777215
    t.integer "scope_id"
    t.integer "user_id"
    t.integer "feed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["feed_id"], name: "index_entries_on_feed_id"
    t.index ["published"], name: "index_entries_on_published"
    t.index ["scope_id"], name: "index_entries_on_scope_id"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "fashion_fly_editor_categories", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "name"
    t.string "slug"
    t.integer "parent_id"
    t.string "parent_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "scope_id"
    t.index ["parent_id", "parent_type"], name: "category_parent"
    t.index ["scope_id"], name: "index_fashion_fly_editor_categories_on_scope_id"
    t.index ["slug"], name: "index_fashion_fly_editor_categories_on_slug", unique: true
  end

  create_table "fashion_fly_editor_collection_items", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "collection_id"
    t.integer "item_id"
    t.integer "position_x"
    t.integer "position_y"
    t.float "width", limit: 24
    t.float "height", limit: 24
    t.float "rotation", limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "image"
    t.integer "scale_x"
    t.integer "scale_y"
    t.integer "order", default: 0
  end

  create_table "fashion_fly_editor_collections", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "title"
    t.text "description"
    t.string "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "category_id"
    t.integer "user_id"
    t.integer "actual_trend"
    t.integer "last_trend"
    t.integer "favorites_count"
    t.boolean "published", default: false
    t.integer "visits_count", default: 0
    t.integer "height"
    t.integer "width"
    t.index ["actual_trend"], name: "index_fashion_fly_editor_collections_on_actual_trend"
    t.index ["category_id"], name: "index_fashion_fly_editor_collections_on_category_id"
    t.index ["favorites_count"], name: "index_fashion_fly_editor_collections_on_favorites_count"
    t.index ["published"], name: "index_fashion_fly_editor_collections_on_published"
    t.index ["user_id"], name: "index_fashion_fly_editor_collections_on_user_id"
  end

  create_table "fashion_fly_editor_subscriptions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "collection_id"
    t.string "subscriber_type"
    t.integer "subscriber_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["collection_id"], name: "index_fashion_fly_editor_subscriptions_on_collection_id"
    t.index ["subscriber_id", "subscriber_type"], name: "subscriber"
  end

  create_table "favorites", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "markable_id"
    t.string "markable_type"
    t.integer "user_id"
    t.string "cookie_store"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["cookie_store"], name: "index_favorites_on_cookie_store", length: { cookie_store: 30 }
    t.index ["created_at"], name: "index_favorites_on_created_at"
    t.index ["markable_id", "markable_type"], name: "index_favorites_on_markable_id_and_markable_type"
    t.index ["markable_id"], name: "index_favorites_on_markable_id"
    t.index ["markable_type"], name: "index_favorites_on_markable_type"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "feeds", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "user_id"
    t.binary "value", limit: 16777215
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_feeds_on_user_id"
  end

  create_table "icons", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "name"
    t.string "image"
    t.index ["name"], name: "index_icons_on_name"
  end

  create_table "lit_incomming_localizations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.text "translated_value"
    t.integer "locale_id"
    t.integer "localization_key_id"
    t.integer "localization_id"
    t.string "locale_str"
    t.string "localization_key_str"
    t.integer "source_id"
    t.integer "incomming_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "localization_key_is_deleted", default: false, null: false
    t.index ["incomming_id"], name: "index_lit_incomming_localizations_on_incomming_id"
    t.index ["locale_id"], name: "index_lit_incomming_localizations_on_locale_id"
    t.index ["localization_id"], name: "index_lit_incomming_localizations_on_localization_id"
    t.index ["localization_key_id"], name: "index_lit_incomming_localizations_on_localization_key_id"
    t.index ["source_id"], name: "index_lit_incomming_localizations_on_source_id"
  end

  create_table "lit_locales", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "locale"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "is_hidden", default: false
  end

  create_table "lit_localization_keys", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "localization_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "is_completed", default: false
    t.boolean "is_starred", default: false
    t.boolean "is_deleted", default: false, null: false
    t.boolean "is_visited_again", default: false, null: false
    t.index ["localization_key"], name: "index_lit_localization_keys_on_localization_key", unique: true
  end

  create_table "lit_localization_versions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.text "translated_value"
    t.integer "localization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["localization_id"], name: "index_lit_localization_versions_on_localization_id"
  end

  create_table "lit_localizations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "locale_id"
    t.integer "localization_key_id"
    t.text "default_value"
    t.text "translated_value"
    t.boolean "is_changed", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["locale_id"], name: "index_lit_localizations_on_locale_id"
    t.index ["localization_key_id", "locale_id"], name: "index_lit_localizations_on_localization_key_id_and_locale_id", unique: true
    t.index ["localization_key_id"], name: "index_lit_localizations_on_localization_key_id"
  end

  create_table "lit_sources", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "identifier"
    t.string "url"
    t.string "api_key"
    t.datetime "last_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "sync_complete"
  end

  create_table "mappings", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "category_id"
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "affiliate_id"
    t.index ["affiliate_id"], name: "index_mappings_on_affiliate_id"
    t.index ["category_id"], name: "index_mappings_on_category_id"
    t.index ["name"], name: "index_mappings_on_name"
  end

  create_table "overall_averages", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "rateable_type"
    t.integer "rateable_id"
    t.float "overall_avg", limit: 24, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "name"
    t.string "title"
    t.text "body"
    t.integer "scope_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "scope_id"], name: "index_pages_on_name_and_scope_id", unique: true
    t.index ["name"], name: "index_pages_on_name"
    t.index ["scope_id"], name: "index_pages_on_scope_id"
  end

  create_table "products", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "affi_code"
    t.string "name"
    t.string "number"
    t.text "description"
    t.integer "brand_id"
    t.integer "colorization_id"
    t.string "ean"
    t.decimal "price", precision: 10, scale: 2
    t.string "shippingHandlingCost"
    t.string "lastModified"
    t.string "image"
    t.string "original"
    t.string "deliveryTime"
    t.string "currencyCode"
    t.text "deepLink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "scope_id"
    t.boolean "published", default: false
    t.integer "actual_trend", default: 0
    t.integer "last_trend", default: 0
    t.integer "favorites_count", default: 0
    t.integer "affiliate_id"
    t.boolean "premium", default: false
    t.integer "width", default: 0
    t.integer "height", default: 0
    t.integer "random_order", default: 0
    t.decimal "sale_price", precision: 10, scale: 2
    t.boolean "sale", default: false
    t.boolean "dirty", default: false
    t.integer "visits_count", default: 0
    t.boolean "removed", default: false
    t.index ["actual_trend"], name: "index_products_on_actual_trend"
    t.index ["affiliate_id", "affi_code", "scope_id"], name: "index_products_on_affiliate_id_and_affi_code_and_scope_id", unique: true
    t.index ["affiliate_id"], name: "index_products_on_affiliate_id"
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["colorization_id"], name: "index_products_on_colorization_id"
    t.index ["dirty"], name: "index_products_on_dirty"
    t.index ["favorites_count"], name: "index_products_on_favorites_count"
    t.index ["premium"], name: "index_products_on_premium"
    t.index ["published"], name: "index_products_on_published"
    t.index ["random_order"], name: "index_products_on_random_order"
    t.index ["removed"], name: "index_products_on_removed"
    t.index ["sale"], name: "index_products_on_sale"
    t.index ["scope_id"], name: "index_products_on_scope_id"
  end

  create_table "properties", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "scope_id"
    t.string "shop_highlight_title"
    t.string "shop_highlight_image"
    t.text "shop_highlight_link"
    t.string "collection_highlight_title"
    t.string "collection_highlight_image"
    t.text "collection_highlight_link"
    t.string "category_highlight_title"
    t.string "category_highlight_image"
    t.text "category_highlight_link"
    t.boolean "show_new_startpage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scope_id"], name: "index_properties_on_scope_id", unique: true
  end

  create_table "rates", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "rater_id"
    t.string "rateable_type"
    t.integer "rateable_id"
    t.float "stars", limit: 24, null: false
    t.string "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type"
    t.index ["rater_id"], name: "index_rates_on_rater_id"
  end

  create_table "rating_caches", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "cacheable_type"
    t.integer "cacheable_id"
    t.float "avg", limit: 24, null: false
    t.integer "qty", null: false
    t.string "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type"
  end

  create_table "rebuilders", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "collection_id", null: false
    t.index ["collection_id"], name: "index_rebuilders_on_collection_id", unique: true
  end

  create_table "scopes", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "country_code"
    t.string "locale"
    t.string "language"
    t.string "region_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "published", default: false
    t.string "facebook"
    t.string "twitter"
    t.string "google"
    t.string "pinterest"
    t.string "instagram"
    t.string "youtube"
    t.text "hidden"
    t.string "meta_keywords"
    t.text "meta_description"
    t.string "board_number"
    t.index ["country_code"], name: "index_scopes_on_country_code", length: { country_code: 10 }
    t.index ["locale"], name: "index_scopes_on_locale", length: { locale: 10 }
    t.index ["published"], name: "index_scopes_on_published"
  end

  create_table "shops", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "name"
    t.string "logo"
    t.text "link"
    t.text "body"
    t.text "sidebar_banner"
    t.text "top_banner"
    t.text "bottom_banner"
    t.integer "scope_id"
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "favorite"
    t.index ["favorite"], name: "index_shops_on_favorite"
    t.index ["position"], name: "index_shops_on_position"
    t.index ["scope_id"], name: "index_shops_on_scope_id"
  end

  create_table "simple_hashtag_hashtaggings", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "hashtag_id"
    t.string "hashtaggable_type"
    t.integer "hashtaggable_id"
    t.index ["hashtag_id"], name: "index_simple_hashtag_hashtaggings_on_hashtag_id"
    t.index ["hashtaggable_id", "hashtaggable_type"], name: "index_hashtaggings_hashtaggable_id_hashtaggable_type"
  end

  create_table "simple_hashtag_hashtags", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "name"
    t.string "scope_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "scope_id"], name: "index_simple_hashtag_hashtags_on_name_and_scope_id", unique: true
    t.index ["name"], name: "index_simple_hashtag_hashtags_on_name"
    t.index ["scope_id"], name: "index_simple_hashtag_hashtags_on_scope_id"
  end

  create_table "synonyms", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
  end

  create_table "synonyms_words", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "synonym_id"
    t.integer "word_id"
    t.index ["synonym_id"], name: "index_synonyms_words_on_synonym_id"
    t.index ["word_id"], name: "index_synonyms_words_on_word_id"
  end

  create_table "taggings", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
  end

  create_table "tags", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "user_authentications", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "user_id"
    t.integer "authentication_provider_id"
    t.string "uid"
    t.string "token"
    t.datetime "token_expires_at"
    t.text "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authentication_provider_id"], name: "index_user_authentications_on_authentication_provider_id"
    t.index ["user_id"], name: "index_user_authentications_on_user_id"
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.string "email", default: "", null: false
    t.string "name"
    t.string "avatar"
    t.string "role", default: "user"
    t.string "slug"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "secret"
    t.string "banner"
    t.text "info"
    t.integer "fashion_fly_editor_collections_count", default: 0
    t.integer "favorites_count", default: 0
    t.integer "five_star_rates_count", default: 0
    t.integer "visitors", default: 0
    t.integer "max_single_collection_share", default: 0
    t.integer "visits_count", default: 0
    t.integer "scope_id"
    t.string "blog_status", default: "NONE"
    t.boolean "is_blogger", default: false
    t.string "blog_title"
    t.text "blog_feed"
    t.string "blog_url"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["is_blogger"], name: "index_users_on_is_blogger"
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
    t.index ["scope_id"], name: "index_users_on_scope_id"
    t.index ["secret"], name: "index_users_on_secret"
    t.index ["slug"], name: "index_users_on_slug"
  end

  create_table "visits", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "user_id"
    t.string "cookie"
    t.integer "visitable_id"
    t.string "visitable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cookie"], name: "index_visits_on_cookie"
    t.index ["user_id", "cookie", "visitable_id", "visitable_type"], name: "visitings", unique: true
    t.index ["user_id"], name: "index_visits_on_user_id"
    t.index ["visitable_id", "visitable_type"], name: "index_visits_on_visitable_id_and_visitable_type"
  end

  create_table "words", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3" do |t|
    t.integer "scope_id"
    t.string "value"
    t.string "type"
    t.index ["scope_id"], name: "index_words_on_scope_id"
    t.index ["type"], name: "index_words_on_type"
  end

end
