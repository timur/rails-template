
module Criteria
  def self.type_for(name)
    all.find { |criteria_type|
      criteria_type.type_name.to_s == name.to_s
    }
  end

  def self.all
    [
      Text
    ]
  end

  class Base
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :id, :integer
  end

  class Text < Base
    attribute :name, :string
    attribute :field_value, :string
    attribute :required, :boolean, default: false

    validate :stuff
    def stuff
      if required && field_value.blank?
        errors.add(:field_value, "Du bist eine Wurst")
      end
    end

    def self.type_name
      :text
    end
  end
end