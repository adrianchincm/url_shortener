# frozen_string_literal: true

require 'test_helper'

class ViewLinkPageTest < ActionDispatch::IntegrationTest
  setup do
    @link = Link.create(target_url: 'https://www.coingecko.com', title: Nokogiri::HTML::Document.parse(HTTParty.get('https://www.coingecko.com').body).title)
  end

  test 'view link page' do
    get "/links/#{@link.id}"

    assert_response :success
    assert_match @link.title, response.body
    assert_match @link.short_url, response.body
    assert_match @link.target_url, response.body

    # assert page link with no clicks
    assert_select 'div', 'Stats'
    assert_select 'td', 'There\'s no clicks on this link yet'
  end
end
