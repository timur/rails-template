class AddSelectedToPicture < ActiveRecord::Migration[7.1]
  def change
    change_table :pictures do |t|
      t.boolean :selected, default: false
    end
  end
end
