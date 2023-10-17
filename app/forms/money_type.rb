# class MonexType < ActiveRecord::Type::Value
class MoneyType < ActiveRecord::Type::Decimal
  def cast(value)
    Rails.logger.debug "In Money Type cast #{value} #{value.class}"
    back = ""
    if value.is_a? String
      back = value.gsub('.', '').sub(',', '.').to_f
    end
    if value.is_a? Float
      back = sprintf("%.2f", value).gsub('.', ',')
    end
    Rails.logger.debug "In Money Type back #{back}"
    back
  end
end