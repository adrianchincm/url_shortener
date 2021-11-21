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
    link = Link.new(target_url: params[:target_url], title: get_url_title)
    if !link.title.nil?
      save_link(link)
    else
      show_invalid_url_error
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

  def show_invalid_url_error
    flash[:error] = "'#{params[:target_url]}' is not a valid URL"
    redirect_back(fallback_location: root_path)
  end

  def save_link(link, retry_count = 0)
    max_retry = 3

    if link.save
      redirect_to link_path(link)
    elsif retry_count <= max_retry
      retry_count += 1
      save_link(link, retry_count)
    else
      flash[:error] = link.errors
      redirect_back(fallback_location: root_path)
    end
  end

  def increment_click(link)
    link.clicks += 1
    link.save
  end

  def create_stat(link_id)
    geocode = Geocoder.search(get_ip)
    Stat.create(link_id: link_id, location: "#{geocode.first.city}, #{geocode.first.country}", timestamp: Time.now)
  end
end
