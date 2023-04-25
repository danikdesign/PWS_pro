# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Passwordless::ControllerHelpers
  include Internationalization

  helper_method :current_user

  private

  def current_user
    @current_user ||= authenticate_by_session(User)
  end

  def require_user!
    return if current_user

    redirect_to auth.sign_in_path, alert: t('passwordless.sessions.create.alert')
  end
end
