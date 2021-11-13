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
end
