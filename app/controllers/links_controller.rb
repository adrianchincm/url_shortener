# frozen_string_literal: true

require 'httparty'
require 'nokogiri'

class LinksController < ApplicationController
  def redirect
    slug = params[:slug]
    link = Link.find_by(short_url_slug: slug)
    increment_click(link)
    create_stat(link.id)
    redirect_to link.target_url
  end

  def create
    if !get_url_title.nil?
      link = Link.create(target_url: params[:target_url], title: get_url_title)
      redirect_to link_path(link)
    else
      flash[:error] = "'#{params[:target_url]}' is not a valid URL"
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @link = Link.find(params[:id])
    @stats = Stat.where(link_id: @link.id)
  end

  def index
    @links = Link.all
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
