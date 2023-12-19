# frozen_string_literal: true

require 'test_helper'

module Backend
  class OutfitCategoriesControllerTest < ActionController::TestCase
    test 'should get index' do
      get :index
      assert_response :success
    end
  end
end
