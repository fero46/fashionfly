# frozen_string_literal: true

require 'logger'
require 'net/http'
require 'open-uri'

class RedirectFollower
  class TooManyRedirects < StandardError; end

  attr_accessor :url, :body, :redirect_limit, :response

  def initialize(url, limit = 5)
    @url = url
    @redirect_limit = limit
    logger.level = Logger::INFO
  end

  def logger
    @logger ||= Logger.new($stdout)
  end

  def resolve
    raise TooManyRedirects if redirect_limit.negative?

    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri, { 'User-Agent' => 'firefox' })
    self.response = http.request(request)

    logger.info "redirect limit: #{redirect_limit}"
    logger.info "response code: #{response.code}"
    logger.debug "response body: #{response.body}"

    if response.is_a?(Net::HTTPRedirection)
      self.url = redirect_url
      self.redirect_limit -= 1

      logger.info "redirect found, headed to #{url}"
      resolve
    end

    self.body = response.body
    self
  end

  def redirect_url
    puts response
    if response['location'].nil?
      response.body.match(/<a href="([^>]+)">/i)[1]
    else
      response['location']
    end
  end
end
