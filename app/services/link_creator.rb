# frozen_string_literal: true

class LinkCreator < ApplicationService
  attr_reader :target_url, :title

  def initialize(target_url, title)
    @target_url = target_url
    @title = title
  end

  def call
    max_retry = 3
    retry_count = 0

    while retry_count <= max_retry
      link = Link.new(target_url: @target_url, title: @title)
      if link.save
        return link
      else
        retry_count += 1
      end
    end

    nil
  end
end
