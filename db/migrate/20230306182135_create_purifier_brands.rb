# frozen_string_literal: true

class CreatePurifierBrands < ActiveRecord::Migration[7.0]
  def change
    create_table :purifier_brands do |t|
      t.string :title

      t.timestamps
    end
  end
end
