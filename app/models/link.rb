# frozen_string_literal: true

require 'httparty'
require 'nokogiri'

class Link < ApplicationRecord
  validates_presence_of :target_url
  validates :target_url, http_url: true
  validates_uniqueness_of :short_url_slug
  after_validation :generate_short_url, :get_link_title, on: :create

  def generate_short_url
    return false unless errors.empty?

    self.short_url_slug = SecureRandom.alphanumeric(8)
    true
  end

  def get_link_title
    return false unless errors.empty?

    self.title = Nokogiri::HTML::Document.parse(HTTParty.get(target_url).body).title
    true
  end

  def short_url
    Rails.application.routes.url_helpers.short_url(slug: short_url_slug)
  end
end
