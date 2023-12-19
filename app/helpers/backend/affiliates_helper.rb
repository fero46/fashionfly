# frozen_string_literal: true

module Backend
  module AffiliatesHelper
    def affiliate_key(affiliate)
      affiliate.updated_at.to_s
    end

    def affiliate_mapping(affiliate, mapping)
      "#{affiliate_key(affiliate)}-#{mapping.name}"
    end
  end
end
