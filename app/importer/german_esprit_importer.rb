# frozen_string_literal: true

require 'net/http'

class GermanEspritImporter < GenericImporter
  protected

  def product_remote_image(values)
    values['largeImage']
  end
end
