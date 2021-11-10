# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.string :target_url
      t.string :short_url_slug
      t.integer :clicks, default: 0

      t.timestamps
    end
  end
end
