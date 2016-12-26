class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :edit, :update, :destroy]

  # GET /packages
  # GET /packages.json
  def index
    filter_params = {}
    filter_params.merge!(language: params[:language]) if params[:language].present?
    @packages = Package.where(filter_params).page(params[:page]).per(5)
  end

  # GET /packages/1
  # GET /packages/1.json
  def show
  end

  # GET /packages/new
  def new
    @package = Package.new
    @package.system_dependencies.build
    respond_to do |format|
      format.js
    end
  end

  # GET /packages/1/edit
  def edit
    respond_to do |format|
      format.js { render :new }
    end
  end

  # POST /packages
  # POST /packages.json
  def create
    @package = Package.new(package_params)

    respond_to do |format|
      if @package.save
        format.js
      else
        @package.system_dependencies.build if @package.system_dependencies.empty?
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /packages/1
  # PATCH/PUT /packages/1.json
  def update
    respond_to do |format|
      if @package.update(package_params)
        format.js
      else
        format.js { render :new}
      end
    end
  end

  # DELETE /packages/1
  # DELETE /packages/1.json
  def destroy
    @package.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package
      @package = Package.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params.require(:package).permit(:name, :language, :source_url, system_dependencies_attributes: [:id, :name, :operating_system, :_destroy])
    end
end
