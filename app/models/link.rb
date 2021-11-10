# frozen_string_literal: true

class Link < ApplicationRecord
  validates_presence_of :target_url
  validates :target_url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates_uniqueness_of :short_url_slug
  before_validation :generate_short_url

  def generate_short_url
    self.short_url_slug = SecureRandom.alphanumeric(8)
    true
  end

  def short_url
    Rails.application.routes.url_helpers.short_url(slug: short_url_slug)
  end
end
