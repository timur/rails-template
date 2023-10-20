class CustomArrayType < ActiveRecord::Type::Value
end

ActiveRecord::Type.register(:my_array, CustomArrayType)