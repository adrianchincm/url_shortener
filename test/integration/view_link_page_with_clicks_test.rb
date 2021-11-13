# frozen_string_literal: true

require 'test_helper'

class ViewLinkPageWithStatsTest < ActionDispatch::IntegrationTest
  setup do
    @link = Link.create(target_url: 'https://www.coingecko.com')
    # to trigger a click event
    get "/u/#{@link.short_url_slug}"
  end

  test 'view link page with at least one row in stats' do
    get "/links/#{@link.id}"
    stat = Stat.last

    assert_response :success
    assert_match @link.title, response.body
    assert_match @link.short_url, response.body
    assert_match @link.target_url, response.body

    # assert that Stats and at least showing one click
    assert_select 'div', 'Stats'
    assert_select 'h2', '1'

    # assert that there is one row with the correct location and timestamp
    assert_select 'td', '1'
    assert_select 'td', stat.location
    assert_select 'td',
                  stat.timestamp.in_time_zone(Rails.application.config.time_zone).strftime('%-l:%M %p, %a %d/%m/%Y')
  end
end
