# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :get_ip

  def get_ip
    if Rails.env.production?
      request.remote_ip
    else
      Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
    end
  end

  def get_url_title
    title = Nokogiri::HTML::Document.parse(HTTParty.get(params[:target_url]).body).title
  rescue StandardError
    title = nil
  ensure
    return title
  end
end
