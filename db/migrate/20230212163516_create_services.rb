# frozen_string_literal: true

class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.date :date
      t.float :pressure
      t.integer :in_tds
      t.integer :out_tds_before
      t.integer :out_tds_after
      t.boolean :status
      t.belongs_to :client, null: false, foreign_key: true
      t.text :notes

      t.timestamps
    end
  end
end
