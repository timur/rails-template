class Person < ApplicationRecord
  include SqliteSearch

  search_scope(:name, :email, :position)

  scope :by_name, ->(name) {
    return if name.blank?

    where(arel_table[:name].matches("#{name}%"))
  }  
end
