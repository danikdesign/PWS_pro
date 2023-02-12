class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.datetime :datetime
      t.belongs_to :installation, null: false, foreign_key: true
      t.belongs_to :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
