class DashboardController < ApplicationController
  def index
    @form = UserForm.new
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
