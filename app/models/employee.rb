class Employee < ApplicationRecord
  include Litesearch::Model

  litesearch do |schema|
    schema.fields [:name, :position, :office, :age, :start_date] # these fields has a weight of 1
  end

  validates :name, presence: true
end
