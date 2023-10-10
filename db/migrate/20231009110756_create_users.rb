class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.date :birthdate
      t.decimal :income, scale: 8, precision: 2

      t.timestamps
    end
  end
end
