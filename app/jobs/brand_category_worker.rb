class BrandCategoryWorker< ActiveJob::Base

  def perform(*args)
    config = ::Configuration.where(key: 'brand_category_worker').first_or_create
    return if config.value == 'running'
    begin
      config.value = 'running'
      config.save
      Product.where(published: true).find_in_batches(batch_size: 500) do |group|
        group.each { |product| brand_category(product) }
      end
    rescue Exception => e
      puts e
    ensure
      config.value = 'not_running'
      config.save
    end
  end

  def self.run
    perform_later()
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