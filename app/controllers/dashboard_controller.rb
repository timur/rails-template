class DashboardController < ApplicationController
  def index
    @form = UserForm.new
  end

  def create
    @form = UserForm.new_with_permitted_params(params)

    respond_to do |format|
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
