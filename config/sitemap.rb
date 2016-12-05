# Change this to your host. See the readme at https://github.com/lassebunk/dynamic_sitemaps
# for examples of multiple hosts and folders.
require 'net/http'

host 'www.fashionfly.co'

Scope.where(published: true).each do |scope|
  folder "sitemaps/#{scope.locale}"

  sitemap :site do
    url root_url(locale: scope.locale), last_mod: Time.now, change_freq: 'daily', priority: 1.0
    scope.categories.each do |category|
      url category_url(scope.locale, category.slug), last_mod: category.updated_at
    end
    scope.outfit_categories.each do |outfit_category|
      url outfit_category_url(scope.locale, outfit_category.slug), last_mod: outfit_category.updated_at
    end
  end

  if scope.products.where(dirty: false).present?
    sitemap :products do
      scope.products.where(dirty: false).find_in_batches(batch_size: 1000) do |group|
        for product in group
          url product_url(scope.locale, product), last_mod: product.updated_at
        end
      end
    end
  end

  if scope.users.present?
    sitemap_for scope.users, name:  :users do |user|
      url profile_url(scope.locale, user.slug), last_mod: user.try(:updated_at)
      url profile_outfits_url(scope.locale, user.slug), last_mod: user.try(:collections).try(:last).try(:updated_at)
      url profile_favorites_url(scope.locale, user.slug), last_mod: user.try(:favorites).try(:last).try(:updated_at)
      if user.is_blogger.present?
        url profile_blog_url(scope.locale, user.slug), last_mod: user.try(:feed).try(:updated_at)
      end
    end
  end

  if scope.entries.present?
    sitemap_for scope.entries, name:  :entries do |entry|
      url entry_url(scope.locale, entry), last_mod: entry.try(:updated_at)
    end
  end

  if scope.collections.where(published: true).present?
    sitemap_for scope.collections.where(published: true), name: :published_collections do |collection|
      url collection_url(scope.locale, collection), last_mod: collection.updated_at
    end
  end

  if scope.hashtags.present?
    sitemap_for scope.hashtags, name: :hashtags do |hashtag|
      url hashtag_url(scope.locale, hashtag.name), last_mod: hashtag.updated_at
    end
  end

  brand_ids = scope.products.group('brand_id').map(&:brand_id)

  brands = Brand.where('id in (?)', brand_ids)

  sitemap :brands do
    for brand in brands
      for category in scope.categories.all
        category.touch
        url brand_category_url(scope.locale, brand.slug, category.slug), last_mod: category.updated_at
        end
      end
  end

  ping_with "http://fashionfly.co/#{scope.locale}/sitemap.xml" if Rails.env == 'production'
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
