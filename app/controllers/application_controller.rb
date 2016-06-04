class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception, if: proc { |c| c.request.xhr? }
  protect_from_forgery with: :null_session, if: proc { |c| c.request.xhr? }

  serialization_scope :view_context

  def index
  end

  def after_sign_in_path_for _resource
    if current_user.admin?
      dashboard_path
    else
      the_court_path
    end
  end

  def authenticate_active_admin_user!
    authenticate_user!

    unless current_user && current_user.admin?
      redirect_to the_court_path, notice: "Not an admin."
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit :sign_up, keys: [:username]
    end
end
