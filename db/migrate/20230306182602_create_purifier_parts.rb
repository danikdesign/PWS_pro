# frozen_string_literal: true

class CreatePurifierParts < ActiveRecord::Migration[7.0]
  def change
    create_table :purifier_parts do |t|
      t.string :title

      t.timestamps
    end
  end
end
