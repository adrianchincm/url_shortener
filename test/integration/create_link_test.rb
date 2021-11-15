# frozen_string_literal: true

require 'test_helper'

class CreateLinkTest < ActionDispatch::IntegrationTest
  test 'create shortened link and go to link page' do
    get '/'
    assert_response :success
    assert_difference 'Link.count', 1 do
      post links_url(target_url: 'https://www.coingecko.com')
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'CoinGecko', response.body
  end
end
