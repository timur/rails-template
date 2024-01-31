class AddIndexToEmployeesName < ActiveRecord::Migration[7.1]
  def change
    add_index :employees, :name
  end
end
