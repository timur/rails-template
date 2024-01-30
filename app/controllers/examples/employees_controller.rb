class Examples::EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update destroy ]

  DEFAULT_COUNT = 10

  # GET /employees
  def index
    @employees = Employee.all
    @employees = @employees.search(params[:query]) if params[:query].present?
    @pagy, @employees = pagy @employees.reorder(sort_column => sort_direction), items: validate_count(params.fetch(:count, DEFAULT_COUNT))
  end

  # GET /employees/1
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: "Employee was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: "Employee #{@employee.name} was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = "Employee #{@employee.name} was successfully deleted."
        redirect_to employees_url, status: :see_other
      end
      format.turbo_stream { flash.now[:success] = "Employee #{@employee.name} was successfully deleted." }
    end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:name, :position, :office, :age, :start_date)
    end
end
