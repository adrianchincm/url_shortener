# frozen_string_literal: true

class LinksController < ApplicationController
  def redirect
    link = LinkRedirector.call(params[:slug], get_ip)
    if link.nil?
      show_invalid_slug_error
    else
      redirect_to link.target_url
    end
  end

  def create
    title = get_url_title
    if !title.nil?
      save_link(title)
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

  def show_invalid_slug_error
    flash[:error] = "'#{params[:slug]}' is not a valid short url slug"
    redirect_back(fallback_location: root_path)
  end

  def save_link(title)
    link = LinkCreator.call(params[:target_url], title)

    if link.nil?
      flash[:error] = 'Unable to generate short url slug'
      redirect_back(fallback_location: root_path)
    else
      redirect_to link_path(link)
    end
  end
end
