class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.datetime :datetime
      t.text :notes
      t.references :ticketable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
