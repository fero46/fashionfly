# frozen_string_literal: true

require 'test_helper'

class WidgetsControllerTest < ActionController::TestCase
  test 'should get show' do
    get :show
    assert_response :success
  end
end
