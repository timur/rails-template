class Bait < ApplicationRecord
  scope :with_name, ->(name) {
    where("lower(name) LIKE ?", "%#{name.downcase}%") if name.present?
  }

  def self.search(params={})
    self
      .with_name(params[:name])
  end
end
