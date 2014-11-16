class TrendCheckWorker
  include Sidekiq::Worker

  def perform
    
    Product.where(published: true).find_in_batches(batch_size: 500) do |group|
      group.each { |product| copy_trend(product) }
    end

    FashionFlyEditor::Collection.where(published: true).find_in_batches(batch_size: 500) do |group|
      group.each { |collection| copy_trend(collection) }
    end

    end_week =  Date.today.beginning_of_week.to_datetime
    start_week = end_week - 7.days

    Favorite.where('created_at >= ?', start_week).where('created_at < ?', end_week).find_in_batches(batch_size: 500) do |group|
      group.each { |favorite| increase_trend(favorite) }
    end

    Product.where(published: true).find_in_batches(batch_size: 500) do |group|
      group.each { |product| recalculate_trend(product) }
    end

    FashionFlyEditor::Collection.where(published: true).find_in_batches(batch_size: 500) do |group|
      group.each { |collection| recalculate_trend(collection) }
    end

  end

  def self.check
    perform_async()
  end


private

  def copy_trend markable
    markable.last_trend = 0
    markable.last_trend = markable.actual_trend if markable.actual_trend
    markable.actual_trend = 0
    markable.save!
  end

  def increase_trend(favorite)
    favorite.markable.increment!(:actual_trend)
  end

  def recalculate_trend markable
    markable.actual_trend = markable.actual_trend + (markable.last_trend * 0.5).to_i
    markable.save
  end

end