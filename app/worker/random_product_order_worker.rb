class RandomProductOrderWorker
  include Sidekiq::Worker

  def perform
    config = ::Configuration.where(name: 'random_product_order_worker').first_or_create
    return if config.value == 'running'
    begin
      config.value = 'running'
      config.save
      max_count = Product.where(published: true).count
      Product.where(published: true).find_in_batches(batch_size: 500) do |group|
        group.each { |product| product.random_order = rand(max_count); product.save }
      end
    rescue Exception => e
      puts e
    ensure
      config.value = 'not_running'
      config.save
    end
  end

  def self.run
    perform_async()
  end
  
end