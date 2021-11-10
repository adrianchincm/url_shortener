# frozen_string_literal: true

require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  def setup
    @link = Link.new(target_url: 'https://www.coingecko.com')
  end

  test 'link should be valid' do
    assert @link.valid?
  end

  test 'target url should be present' do
    @link.target_url = ''
    assert_raise(Errno::ECONNREFUSED) do
      @link.save
    end
  end

  test 'target url should be in proper format' do
    @link.target_url = 'coingecko.com'
    assert_raise(Errno::ECONNREFUSED) do
      @link.save
    end
  end

  test 'target url should save successfully when in proper format' do
    @link.save
    assert_not_empty @link.target_url
    assert_not_empty @link.short_url_slug
    assert_not_empty @link.title
    assert_equal(0, @link.clicks)
  end
end
