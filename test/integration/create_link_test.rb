# frozen_string_literal: true

require 'test_helper'

class CreateLinkTest < ActionDispatch::IntegrationTest
  setup do
    @link = Link.create(target_url: 'https://www.coingecko.com')
  end

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

  test 'redirect to target url from shortened url' do
    get "/u/#{@link.short_url_slug}"
    assert_response :redirect

    follow_redirect!

    assert_equal 'www.coingecko.com', host
  end

  test 'view link page' do
    get "/links/#{@link.id}"

    assert_response :success
    assert_match @link.title, response.body
    assert_match @link.short_url, response.body
    assert_match @link.target_url, response.body
  end
end
