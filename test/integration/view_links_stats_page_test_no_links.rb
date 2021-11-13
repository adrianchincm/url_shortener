# frozen_string_literal: true

require 'test_helper'

class ViewLinkStatsPageTest < ActionDispatch::IntegrationTest

  setup do
    Link.delete_all
  end

  test 'view link stats page with no links generated' do
    get "/links"

    assert_response :success    

    # assert link stats page with no links generated
    assert_select 'h2', 'Stats'
    assert_select 'p', 'Check your shortened links\' performance!'
    assert_select 'td', 'There\'s no shortened links generated yet'    
  end
end
