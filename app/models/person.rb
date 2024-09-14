class Person < ApplicationRecord
  include SqliteSearch

  search_scope(:name, :email, :position)

  scope :by_name, -> (name) {
    return if name.blank?

    where(arel_table[:name].matches("#{name}%"))
  }

  def self.search_string(query)
    tokens = query.split(' ')

    # Quote each token with double quotes
    quoted_tokens = tokens.map { |token| "\"#{token}\"" }

    # Join the quoted tokens with ' OR '
    joined_tokens = quoted_tokens.join(' OR ')

    # Wrap the entire string in single quotes and append an asterisk
    "'#{joined_tokens} *'"
    #Person.full_search('"salena@rau-wunsch.example" OR "Vater" *').count
  end
end
