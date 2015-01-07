class RandomProductOrderWorker
  include Sidekiq::Worker

  def perform
    max_count = Product.where(published: true).count
    Product.where(published: true).find_in_batches(batch_size: 500) do |group|
      group.each { |product| product.random_order = rand(max_count); product.save }
    end
  end

  def self.run
    perform_async()
  end
  
end