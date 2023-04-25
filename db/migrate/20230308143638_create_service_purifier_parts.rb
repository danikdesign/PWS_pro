# frozen_string_literal: true

class CreateServicePurifierParts < ActiveRecord::Migration[7.0]
  def change
    create_table :service_purifier_parts do |t|
      t.belongs_to :service, null: false, foreign_key: true
      t.belongs_to :purifier_part, null: false, foreign_key: true

      t.timestamps
    end
  end
end
