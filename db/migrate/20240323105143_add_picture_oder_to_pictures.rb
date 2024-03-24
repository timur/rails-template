class AddPictureOderToPictures < ActiveRecord::Migration[7.1]
  def change
    add_column :pictures, :picture_order, :integer
  end
end
