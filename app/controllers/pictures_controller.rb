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
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to picture_url(@picture), notice: "Picture was successfully updated." }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def picture_params
      params.require(:picture).permit(:name, :image)
    end
  
    def unsplash_link(id, width, height)
      "https://source.unsplash.com/#{id}/#{width}x#{height}"
    end

    def photos
      breakpoints = [1080, 640, 384, 256, 128, 96, 64, 48]
      
      unsplash_photos = [
        { id: "8gVv6nxq6gY", width: 1080, height: 800 },
        { id: "Dhmn6ete6g8", width: 1080, height: 1620 },
        { id: "RkBTPqPEGDo", width: 1080, height: 720 },
        { id: "Yizrl9N_eDA", width: 1080, height: 721 },
        { id: "KG3TyFi0iTU", width: 1080, height: 1620 },
        { id: "Jztmx9yqjBw", width: 1080, height: 607 },
        { id: "-heLWtuAN3c", width: 1080, height: 608 },
        { id: "xOigCUcFdA8", width: 1080, height: 720 },
        { id: "1azAjl8FTnU", width: 1080, height: 1549 },
        { id: "ALrCdq-ui_Q", width: 1080, height: 720 },
        { id: "twukN12EN7c", width: 1080, height: 694 },
        { id: "9UjEyzA6pP4", width: 1080, height: 1620 },
        { id: "sEXGgun3ZiE", width: 1080, height: 720 },
        { id: "S-cdwrx-YuQ", width: 1080, height: 1440 },
        { id: "q-motCAvPBM", width: 1080, height: 1620 },
        { id: "Xn4L310ztMU", width: 1080, height: 810 },
        { id: "iMchCC-3_fE", width: 1080, height: 610 },
        { id: "X48pUOPKf7A", width: 1080, height: 160 },
        { id: "GbLS6YVXj0U", width: 1080, height: 810 },
        { id: "9CRd1J1rEOM", width: 1080, height: 720 },
        { id: "xKhtkhc9HbQ", width: 1080, height: 1440 }
      ]
      
      photos = unsplash_photos.map do |photo|
        {
          src: unsplash_link(photo[:id], photo[:width], photo[:height]),
          width: photo[:width],
          height: photo[:height],
          srcSet: breakpoints.map do |breakpoint|
            height = (photo[:height] * breakpoint.to_f / photo[:width]).round
            {
              src: unsplash_link(photo[:id], breakpoint, height),
              width: breakpoint,
              height: height
            }
          end
        }
      end

      photos.to_json
    end
end
