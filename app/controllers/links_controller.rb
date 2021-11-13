# frozen_string_literal: true

class LinksController < ApplicationController
  def redirect
    slug = params[:slug]
    link = Link.find_by(short_url_slug: slug)
    increment_click(link)
    create_stat(link.id)
    redirect_to link.target_url
  end

  def create
    link = Link.create(target_url: params[:target_url])
    redirect_to link_path(link)
  end

  def show
    @link = Link.find(params[:id])
  end

  private

  def increment_click(link)
    link.clicks += 1
    link.save
  end

  def create_stat(link_id)
    geocode = Geocoder.search(get_ip)
    Stat.create(link_id: link_id, location: "#{geocode.first.city}, #{geocode.first.country}", timestamp: Time.now)
  end
end
