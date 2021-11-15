# frozen_string_literal: true

require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  def setup
    @link = Link.new(target_url: 'https://www.coingecko.com', title: Nokogiri::HTML::Document.parse(HTTParty.get('https://www.coingecko.com').body).title)
  end

  test 'link should be valid' do
    assert @link.valid?
  end

  test 'target url should fail if no target_url' do
    link = Link.new
    assert_not link.valid?
  end

  test 'shortened link should save successfully' do
    @link.save
    assert_not_empty @link.target_url
    assert_not_empty @link.short_url_slug
    assert_not_empty @link.title
    assert_equal(0, @link.clicks)
  end
end
