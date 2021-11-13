# frozen_string_literal: true

class CreateStats < ActiveRecord::Migration[6.1]
  def change
    create_table :stats do |t|
      t.integer :link_id
      t.datetime :timestamp
      t.string :location

      t.timestamps
    end
  end
end
