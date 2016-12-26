class Api::V1::PackagesController < ApplicationController
  # Filters
  skip_before_action :verify_authenticity_token, only: [:fetch]
  before_action :set_operating_system, only: [:fetch]
  before_action :set_language, only: [:fetch]
  before_action :set_packages, only: [:fetch]

  # Actions
  def fetch
    @packages = Package.includes(:system_dependencies)
                       .where(language: @language, name: @packages)
                       .where(system_dependencies: { operating_system: @os })
    render json: @packages.as_json(
      only: :name, include: [system_dependencies: { only: :name }]
    )
  end

  # Private Section
  private

  def set_operating_system
    if SystemDependency.operating_systems.keys.include? params[:os]
      @os = SystemDependency.operating_systems[params[:os]]
    else
      render json: {
        error_message: 'Unsupported OS'
      }, status: :bad_request
    end
  end

  def set_language
    if Package.languages.keys.include? params[:language]
      @language = Package.languages[params[:language]]
    else
      render json: {
        error_message: 'Unsupported Language'
      }, status: :bad_request
    end
  end

  def set_packages
    if params[:packages].is_a? Array
      @packages = params[:packages]
    else
      render json: {
        error_message: 'Packages should be array'
      }, status: :unprocessable_entity
    end
  end
end
