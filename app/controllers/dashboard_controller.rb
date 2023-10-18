class DashboardController < ApplicationController
  def index
    @form = UserForm.new
    @criteria = 
      [
        Criteria::Text.new(id: 0, name: "Wurst 1"),
        Criteria::Text.new(id: 1, name: "Wurst 2", required: true)
      ]
  end

  def fields
    @criteria = if params[:"[criteria_attributes]"].present? && params[:commit] != "Reset"
      params[:"[criteria_attributes]"].values.map { |criteria|
        criteria_class = Criteria.type_for(criteria[:type_name])
        criteria_class.new(criteria.except(:type_name).permit(:id, :name, :field_value, :required))
      }
    else
      [
        Criteria::Text.new(id: 0, name: "Wurst 1"),
        Criteria::Text.new(id: 1, name: "Wurst 2", required: true)
      ]
    end

    @criteria.each do |criteria|
      criteria.valid?
    end
    
    Rails.logger.debug "Criteria: #{@criteria[0].name} Value: #{@criteria[0].field_value}"
    Rails.logger.debug "Criteria: #{@criteria[1].name} Value: #{@criteria[1].field_value}"

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update(
            'new_fields',
            partial: "dashboard/criterias",
            locals: { criteria: @criteria })
          ]
      end
    end    
  end

  def create
    @form = UserForm.new_with_permitted_params(params)
    logger.debug "Form Attributes #{@form.attributes}"
    logger.debug "Salary #{@form.salary} #{@form.salary.class}"
    respond_to do |format|
      #@form.salary = "100,99"
      if @form.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(
              'new_form',
              partial: "dashboard/form",
              locals: { form: UserForm.new }),
            ]
        end
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(
              'new_form',
              partial: "dashboard/form",
              locals: { form: @form })
            ]
        end
      end
    end
  end
end
