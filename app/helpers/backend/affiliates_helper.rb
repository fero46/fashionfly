module Backend::AffiliatesHelper

  def affiliate_key affiliate
    "#{affiliate.updated_at}"
  end

  def affiliate_mapping affiliate, mapping
    "#{affiliate_key(affiliate)}-#{mapping.name}"
  end

end
