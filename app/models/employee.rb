class Employee < ApplicationRecord
  validates :name, presence: true

  scope :by_name, ->(name) {
    return if name.blank?

    where(arel_table[:name].matches("%#{name}%"))
  }

  def self.scheduled_name
    Employee.create(name: "Scheduled User at #{Time.now}")
  end
end
