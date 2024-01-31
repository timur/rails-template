class Employee < ApplicationRecord
  validates :name, presence: true

  scope :by_name, ->(name) {
    return if name.blank?

    where(arel_table[:name].matches("%#{name}%"))
  }
end
