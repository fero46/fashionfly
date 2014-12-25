# Change this to your host. See the readme at https://github.com/lassebunk/dynamic_sitemaps
# for examples of multiple hosts and folders.
require "net/http"

host "fashionfly.co"

Scope.where(published: true).each do |scope|
  folder "sitemaps/#{scope.locale}"

  sitemap :site do
    url root_url(locale: scope.locale), last_mod: Time.now, change_freq: "daily", priority: 1.0
    scope.categories.each do |category|
      url category_path(scope.locale, category.slug), last_mod: category.updated_at
    end
    scope.outfit_categories.each do |outfit_category|
      url outfit_category_path(scope.locale,outfit_category.slug), last_mod: outfit_category.updated_at
    end
  end

  sitemap_for scope.products.where(published: true), name: :published_products do |product|
    url product_url(scope.locale,product), last_mod: product.updated_at
  end

  sitemap_for scope.collections.where(published: true), name: :published_collections do |collection|
    url collection_url(scope.locale,collection), last_mod: collection.updated_at
  end

  sitemap_for scope.hashtags, name: :hashtags do |hashtag|
    url hashtag_url(scope.locale, hashtag.name), last_mod: hashtag.updated_at
  end

  ping_with sitemap_url(locale: scope.locale) if Rails.env=='production'


end


# You can have multiple sitemaps like the above – just make sure their names are different.

# Automatically link to all pages using the routes specified
# using "resources :pages" in config/routes.rb. This will also
# automatically set <lastmod> to the date and time in page.updated_at:
#
#   sitemap_for Page.scoped

# For products with special sitemap name and priority, and link to comments:
#
#   sitemap_for Product.published, name: :published_products do |product|
#     url product, last_mod: product.updated_at, priority: (product.featured? ? 1.0 : 0.7)
#     url product_comments_url(product)
#   end

# If you want to generate multiple sitemaps in different folders (for example if you have
# more than one domain, you can specify a folder before the sitemap definitions:
# 
#   Site.all.each do |site|
#     folder "sitemaps/#{site.domain}"
#     host site.domain
#     
#     sitemap :site do
#       url root_url
#     end
# 
#     sitemap_for site.products.scoped
#   end

# Ping search engines after sitemap generation:
#
#   ping_with "http://#{host}/sitemap.xml"