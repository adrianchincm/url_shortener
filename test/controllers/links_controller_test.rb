# frozen_string_literal: true

require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @link = Link.create(target_url: 'https://www.coingecko.com')
  end

  test 'should redirect to target url' do
    get short_url(@link.short_url_slug)
    assert_response :redirect
    assert_redirected_to @link.target_url
  end

  test 'should redirect to target url and create a stat model' do
    assert_difference 'Stat.count', 1 do
      get short_url(@link.short_url_slug)
      assert_response :redirect
      assert_redirected_to @link.target_url
    end

    assert_equal @link.id, Stat.last.link_id
    assert_not_nil Stat.last.timestamp
    assert_not_nil Stat.last.location
  end

  test 'should redirect to target url and increase click count' do
    assert_difference 'Link.last.clicks', 1 do
      get short_url(@link.short_url_slug)
      assert_response :redirect
      assert_redirected_to @link.target_url
    end
  end

  test 'should create link and redirect to link page' do
    post links_url(target_url: 'https://www.google.com')

    assert_redirected_to link_path(Link.last)
  end

  test 'should show link page' do
    get link_url(@link)
    assert_response :success
  end

  test 'should show stats/links index page' do
    get links_url
    assert_response :success
  end
end
