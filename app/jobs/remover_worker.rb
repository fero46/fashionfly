# frozen_string_literal: true

class RemoverWorker < ActiveJob::Base
  def perform(product_id)
    product = Product.where(id: product_id).first
    return unless product.present?

    product.removed = true
    product.save
  end

  def self.run(product)
    return if product.blank?

    perform_later(product.id)
  end
end
