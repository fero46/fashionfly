# frozen_string_literal: true

require 'test_helper'

class BlogsControllerTest < ActionController::TestCase
  test 'should get edit' do
    get :edit
    assert_response :success
  end

  test 'should get show' do
    get :show
    assert_response :success
  end
end
