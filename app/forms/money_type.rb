class MoneyType < ActiveRecord::Type::Decimal
  def cast(value)
    back = ""
    if value.is_a? String
      back = value.gsub('.', '').sub(',', '.').to_f
    end
    if value.is_a? Float
      back = sprintf("%.2f", value).gsub('.', ',')
    end
    back
  end
end

ActiveRecord::Type.register(:money, MoneyType)