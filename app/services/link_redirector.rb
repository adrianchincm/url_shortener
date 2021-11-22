# frozen_string_literal: true

class LinkRedirector < ApplicationService
  attr_reader :slug

  def initialize(slug, ip)
    @slug = slug
    @ip = ip
  end

  def call
    link = Link.find_by(short_url_slug: @slug)
    if link.nil?
      return nil
    else
      StatsWorker.perform_async(link.id, Time.current, @ip)
    end

    link
  end
end
