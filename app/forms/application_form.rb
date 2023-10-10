class ApplicationForm
  # ActiveModel: We get validations, model_name stuff, etc.
  # now our object quaks almost like an ActiveRecord::Base model
  include ActiveModel::Model

  # Gives us the `attribute `` method to define attributes with data types:
  #  attribute :email, :string,
  #  attribute :active, :boolean, default: true
  include ActiveModel::Attributes

  # Helper Method to call from the controller:
  #
  #  MyForm.new_with_permitted_params(params)
  #
  # It fetches the correct key, e.g. params.require(:my_form).permit(:a, :b, c: [], d: {})
  def self.new_with_permitted_params(params)
    permitted_params = params.
      require(model_name.param_key).
      permit(*permitted_params_arguments)
    new(permitted_params)
  end

  # Maps the defined `attributes` to a argument list for params.permit()
  #  Array and Hash attribues must be written in hash form.
  def self.permitted_params_arguments
    structures, primitives = attribute_types.
      map { |name, type|
        if type == :array
          { name => [] }
        elsif type == :hash
          { name => {} }
        else
          name
        end
      }.partition { |i| i.is_a?(Hash) } # rubocop:disable Style/MultilineBlockChain
    params = [*primitives, structures.reduce(&:merge)].reject(&:blank?)
    if params.length == 1
      params.first
    else
      params
    end
  end

  # placeholder to implement by the inherited form instances
  def save
    return false unless valid?

    raise NotImplementedError
  end
end