class RemoverWorker
  include Sidekiq::Worker

  def perform(product_id)
    product = Product.where(id: product_id).first
    if product.present?
      product.removed = true
      product.save
    end
  end

  def self.run product
    return if product.blank?
    perform_async(product.id)
  end

end
