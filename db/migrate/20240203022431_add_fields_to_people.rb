class AddFieldsToPeople < ActiveRecord::Migration[7.1]
  def change
    add_column :people, :email, :string
    add_column :people, :department, :string    
  end
end
