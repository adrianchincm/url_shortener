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

  test 'should create link and redirect to link page' do
    post links_url(target_url: 'https://www.google.com')

    assert_redirected_to link_path(Link.last)
  end

  test 'should show link page' do
    get link_url(@link)
    assert_response :success
  end
end
