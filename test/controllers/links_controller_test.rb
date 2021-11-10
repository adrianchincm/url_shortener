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
end
