class BrandCategoryWorker
  include Sidekiq::Worker

  def perform
    Product.where(published: true).find_in_batches(batch_size: 500) do |group|
      group.each { |product| brand_category(product) }
    end
  end

  def self.run
    perform_async()
  end

  def brand_category product
    brand = product.brand
    if brand.present?
      for category in product.categories
        begin
          category.brands << brand
        rescue
        end
      end
    end
  end

end