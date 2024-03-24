class Picture < ApplicationRecord
  include RankedModel

  ranks :picture_order
  has_one_attached :image
end
