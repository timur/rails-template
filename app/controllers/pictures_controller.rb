class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy ]

  # GET /pictures or /pictures.json
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1 or /pictures/1.json
  def show
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures or /pictures.json
  def create
    @picture = Picture.new(picture_params)

    respond_to do |format|
      if @picture.save
        format.html { redirect_to picture_url(@picture), notice: "Picture was successfully created." }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1 or /pictures/1.json
  def update
    imagekit_service = ImagekitService.new
    respond_to do |format|
      if @picture.update(picture_params)
        @picture_data = imagekit_service.picture_data_slim
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1 or /pictures/1.json
  def destroy
    @picture.destroy!

    respond_to do |format|
      format.html { redirect_to pictures_url, notice: "Picture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def unselect_all
    @picture_ids = Picture.where(selected: true).pluck(:id)
    Picture.update_all(selected: false)
    imagekit_service = ImagekitService.new
    @picture_data = imagekit_service.picture_data
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy_selected
    @picture_ids = Picture.where(selected: true).pluck(:id)
    Picture.where(selected: true).destroy_all
    imagekit_service = ImagekitService.new
    @picture_data = imagekit_service.picture_data
    respond_to do |format|
      format.turbo_stream
    end
  end

  def render_picture
    imagekit_service = ImagekitService.new
    @picture = Picture.find(params[:id])
    data = imagekit_service.data_for_picture_alternate(@picture, params[:width], params[:height])
    render partial: 'examples/upload/picture', locals: { picture: @picture, data: data }, layout: false
  end    

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def picture_params
      params.require(:picture).permit(:name, :image, :selected)
    end
  
end
