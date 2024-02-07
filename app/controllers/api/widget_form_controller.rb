class Api::WidgetFormController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[ create ]

  def new
    @form = Examples::UserForm.new
    respond_to do |format|
      format.turbo_stream
    end
  end

  def create
    @form = Examples::UserForm.new_with_permitted_params(params)
  
    respond_to do |format|
      if @form.save
        format.turbo_stream
      else
        format.turbo_stream { render :new }
      end
    end
  end
end