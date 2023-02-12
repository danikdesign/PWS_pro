class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.date :date
      t.string :replaced
      t.float :pressure
      t.integer :incoming_tds
      t.integer :out_tds_before
      t.integer :out_tds_after
      t.date :next_date
      t.belongs_to :client, null: false, foreign_key: true
      t.text :notes

      t.timestamps
    end
  end
end
