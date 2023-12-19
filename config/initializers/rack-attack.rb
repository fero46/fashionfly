# frozen_string_literal: true

module Rack
  class Attack
    blocklist('block 115.236.75.201') do |req|
      req.ip == '115.236.75.201'
      req.ip == '199.115.117.212'
      req.ip == '199.46.124.12'
    end
  end
end
