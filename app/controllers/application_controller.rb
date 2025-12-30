class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  stale_when_importmap_changes

  before_action :set_navbar_sections

  private

  def set_navbar_sections
    @navbar_sections ||= Section.includes(:categories).all
  end
end
