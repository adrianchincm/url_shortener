# frozen_string_literal: true

require 'httparty'
require 'nokogiri'

class Link < ApplicationRecord
  validates_presence_of :target_url
  validates :target_url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates_uniqueness_of :short_url_slug
  before_validation :generate_short_url, :get_link_title

  def generate_short_url
    self.short_url_slug = SecureRandom.alphanumeric(8)
    true
  end

  def get_link_title
    self.title = Nokogiri::HTML::Document.parse(HTTParty.get(target_url).body).title
    true
  end

  def short_url
    Rails.application.routes.url_helpers.short_url(slug: short_url_slug)
  end
end
