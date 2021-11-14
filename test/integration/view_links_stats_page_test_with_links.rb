# frozen_string_literal: true

require 'test_helper'

class ViewLinkStatsPageTest < ActionDispatch::IntegrationTest
  setup do
    @link = Link.create(target_url: 'https://www.coingecko.com')
  end

  test 'view link stats page with links generated' do
    get '/links'

    assert_response :success

    # assert link stats page with links generated
    assert_select 'h2', 'Stats'
    assert_select 'p', 'Check your shortened links\' performance!'

    # assert link stats page with at least one link/row
    assert_select 'td', '1'
    assert_select 'td', @link.title
    assert_select 'td', @link.clicks
  end
end
