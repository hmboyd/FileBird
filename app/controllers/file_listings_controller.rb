class FileListingsController < ApplicationController
  before_action :set_file_listing, only: %i[ show edit update destroy ]

  # GET /file_listings or /file_listings.json
  def index
    @file_listings = FileListing.all
  end

  # GET /file_listings/1 or /file_listings/1.json
  def show
  end

  # GET /file_listings/new
  def new
    @file_listing = FileListing.new
  end

  # GET /file_listings/1/edit
  def edit
  end

  # POST /file_listings or /file_listings.json
  def create
    @file_listing = FileListing.new(file_listing_params)

    respond_to do |format|
      if @file_listing.save
        format.html { redirect_to @file_listing, notice: "File listing was successfully created." }
        format.json { render :show, status: :created, location: @file_listing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @file_listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /file_listings/1 or /file_listings/1.json
  def update
    respond_to do |format|
      if @file_listing.update(file_listing_params)
        format.html { redirect_to @file_listing, notice: "File listing was successfully updated." }
        format.json { render :show, status: :ok, location: @file_listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @file_listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /file_listings/1 or /file_listings/1.json
  def destroy
    @file_listing.destroy
    respond_to do |format|
      format.html { redirect_to file_listings_url, notice: "File listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_file_listing
      @file_listing = FileListing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def file_listing_params
      params.require(:file_listing).permit(:file_name, :file_path, :last_modified)
    end
end
