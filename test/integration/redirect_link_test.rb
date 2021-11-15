# frozen_string_literal: true

require 'test_helper'

class RedirectLinkTest < ActionDispatch::IntegrationTest
  setup do
    @link = Link.create(target_url: 'https://www.coingecko.com', title: Nokogiri::HTML::Document.parse(HTTParty.get('https://www.coingecko.com').body).title)
  end

  test 'redirect to target url from shortened url' do
    get "/u/#{@link.short_url_slug}"
    assert_response :redirect

    follow_redirect!

    assert_equal 'www.coingecko.com', host
  end
end
