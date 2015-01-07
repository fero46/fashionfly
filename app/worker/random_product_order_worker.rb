class RandomProductOrderWorker
  include Sidekiq::Worker

  def perform
    max_count = Product.count
    scopes = Scope.where(published: true)
    for scope in scopes
      categories = scope.categories
      for category in categories
        max_count = category_product(category).count
        category_product(category).find_in_batches(batch_size: 500) do |group|
          group.each { |product| product.random_order = rand(max_count); product.save }
        end
      end
    end
  end

  def category_product category
    category.products.where(published: true)
  end


  def self.run
    perform_async()
  end
end