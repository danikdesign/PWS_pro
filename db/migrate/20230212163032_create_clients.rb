class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :address
      t.string :purifier_brand
      t.integer :purifier_stages
      t.integer :purifier_tank
      t.boolean :purifier_pump

      t.timestamps
    end
  end
end
