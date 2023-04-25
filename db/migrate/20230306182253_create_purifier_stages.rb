# frozen_string_literal: true

class CreatePurifierStages < ActiveRecord::Migration[7.0]
  def change
    create_table :purifier_stages do |t|
      t.integer :number

      t.timestamps
    end
  end
end
