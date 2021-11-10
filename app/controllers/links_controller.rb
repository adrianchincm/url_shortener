# frozen_string_literal: true

class LinksController < ApplicationController
  def redirect
    slug = params[:slug]
    link = Link.find_by(short_url_slug: slug)
    redirect_to link.target_url
  end
end
