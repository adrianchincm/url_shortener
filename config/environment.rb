# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

UrlShortener::Application.default_url_options = UrlShortener::Application.config.action_mailer.default_url_options
