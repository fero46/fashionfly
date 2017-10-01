class Api::ApiController < ScopeController
  respond_to :json

  before_action :check_format

  # http://blog.rudylee.com/2013/10/29/rails-4-cors/
  skip_before_action :verify_authenticity_token
  before_action :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def check_format
    render :nothing => true, :status => 406 unless params[:format] == 'json' || request.headers["Accept"] =~ /json/
  end

  private

  # For all responses in this controller, return the CORS access control headers.
  def cors_set_access_control_headers
    return if Rails.env.production?
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.
  def cors_preflight_check
    return if Rails.env.production?
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version X-CSRF-TOKEN'
    headers['Access-Control-Max-Age'] = '1728000'
  end

end
