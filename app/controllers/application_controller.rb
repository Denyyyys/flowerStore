class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def require_moderator_access_or_more(error_message = "You can't do that!")
    unless user_signed_in? && (current_user.moderator? || current_user.admin?)
      redirect_to root_path,  flash: { notice: error_message, type: "error" }
    end
  end

  def check_admin
    redirect_to root_path, alert: "Access denied." unless current_user.role == "admin"
  end
end
