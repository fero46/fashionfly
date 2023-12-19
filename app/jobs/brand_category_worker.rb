# frozen_string_literal: true

class BrandCategoryWorker < ActiveJob::Base
  def perform(*_args)
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
    perform_later
  end

  def brand_category(product)
    brand = product.brand
    return unless brand.present?

    product.categories.each do |category|
      category.brands << brand
    rescue StandardError
    end
  end
end
