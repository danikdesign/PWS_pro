class CreateInstallations < ActiveRecord::Migration[7.0]
  def change
    create_table :installations do |t|
      t.date :date
      t.float :pressure
      t.integer :incoming_tds
      t.integer :out_tds
      t.text :notes
      t.belongs_to :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
