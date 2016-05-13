class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception, if: Proc.new { |c| c.request.xhr? }
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.xhr? }

  serialization_scope :view_context

  def index
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit :sign_up, keys: [:username]
    end
end
