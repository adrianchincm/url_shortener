# frozen_string_literal: true

class StatsWorker
  include Sidekiq::Worker

  def perform(link_id, time, ip)
    geocode = Geocoder.search(ip)
    Stat.create(link_id: link_id, location: "#{geocode.first.city}, #{geocode.first.country}", timestamp: time)
    link = Link.find(link_id)
    link.clicks += 1
    link.save
  end
end
