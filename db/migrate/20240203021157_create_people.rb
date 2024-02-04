class CreatePeople < ActiveRecord::Migration[7.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :position
      t.string :status
      t.integer :portfolio

      t.timestamps
    end
  end
end
