class TrendCheckWorker
  include Sidekiq::Worker

  def perform
    end_week =  Date.today.beginning_of_week.to_datetime
    start_week = end_week - 7.days
    favorites = Favorite.where('created_at >= ?', start_week).where('created_at < ?', end_week)
    Product.find_in_batches(batch_size: 500) do |group|
      group.each { |product| product.copy_trend! }
    end

    for favorite in favorites
      product_favorite_counter_cache[favorite.product_id] = 0 if product_favorite_counter_cache[favorite.product_id].blank?
      product_favorite_counter_cache[favorite.product_id]+=1 
    end

    Product.where(true).find_in_batches( batch_size: 250) do |group|
      group.each { |product| product.add_previous_trend!(product_favorite_counter_cache[product.id]) }
    end

  end

  def self.check
    perform_async()
  end

  def product_favorite_counter_cache
    @product_favorite_counter_cache ||={}
  end


end