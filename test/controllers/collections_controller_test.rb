# frozen_string_literal: true

require 'test_helper'

class CollectionsControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get show' do
    get :show
    assert_response :success
  end
end
