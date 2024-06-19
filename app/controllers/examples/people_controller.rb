class Examples::PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update destroy ]

  DEFAULT_COUNT = 10

  def index
    @people = Person.all
    @people = Person.full_search(Person.search_string(params[:query])) if params[:query].present?

    @pagy, @people = pagy @people.reorder(sort_column => sort_direction), items: validate_count(params.fetch(:count, DEFAULT_COUNT))
  end

  def show
  end

  def new
    @person = Person.new
  end

  def edit
    @form = Examples::PersonForm.new @person.as_json.except("id", "created_at", "updated_at")
  end

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

  def update
    form = Examples::PersonForm.new_with_permitted_params(params)
    respond_to do |format|
      if form.save
        @person.update(people_params)
        format.turbo_stream {
          flash.now[:notice] = "Person #{@person.name} was successfully updated."
        }        
      else
        format.html { render partial: 'examples/people/form', locals: { form: } }
      end
    end
  end

  def destroy
    @person.destroy
    respond_to do |format|
      format.html do
        flash[:info] = { title: "Person gelöscht", message: "Person #{@person.name} was successfully deleted." }
        redirect_to examples_people_url, status: :see_other
      end
      format.turbo_stream {
        flash.now[:info] = { title: "Person gelöscht", message: "Die Person #{@person.name} wurde erfolgreich gelöscht." }
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

    def people_params
      params.require(:examples_person_form).permit(:name, :position, :status, :portfolio, :email, :department)
    end
end
