class Examples::PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update destroy ]

  DEFAULT_COUNT = 10

  def index
    @people = Person.all
    @people = Person.by_name(params[:query]) if params[:query].present?

    @pagy, @people = pagy @people.reorder(sort_column => sort_direction), items: validate_count(params.fetch(:count, DEFAULT_COUNT))
  end

  def show
  end

  def new
    @person = Person.new
  end

  def edit
  end

  # POST /people
  def create
    @person = Person.new(employee_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: "Person was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  def update
    respond_to do |format|
      if @person.update(employee_params)
        format.html { redirect_to @person, notice: "Person #{@person.name} was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  def destroy
    @person.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = "Person #{@person.name} was successfully deleted."
        redirect_to people_url, status: :see_other
      end
      format.turbo_stream {
        flash.now[:notice] = "Person #{@person.name} was successfully deleted."
      }
    end
  end

  private

    def sort_column
      %w{ name position status portfolio department }.include?(params[:sort]) ? params[:sort] : "name"
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
    def set_person
      @person = Person.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:person).permit(:name, :position, :status, :portfolio, :email, :department)
    end
end
