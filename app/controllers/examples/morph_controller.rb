class Examples::MorphController < ApplicationController

  DEFAULT_COUNT = 10

  def index
    @employees = Employee.all
    @employees = Employee.by_name(params[:query]) if params[:query].present?

    @pagy, @employees = pagy @employees.reorder(sort_column => sort_direction), items: validate_count(params.fetch(:count, DEFAULT_COUNT))
  end

  private

  def sort_column
    %w{ name position office age start_date }.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w{ asc desc }.include?(params[:direction]) ? params[:direction] : "asc"
  end

  def validate_count value
    count = PagesHelper::PAGINATE_OPTIONS.include?(value.to_i) ? value : DEFAULT_COUNT
    params[:count] = count
    count
  end  

end
