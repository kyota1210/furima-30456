class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :config_permitted_parameters, if: :devise_controller?

  def search_item
    @p = Item.ransack(params[:q])
    @results = @p.result
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def config_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:
      [:nickname, :first_name, :last_name, :read_first_name, :read_last_name, :birthday])
  end
end
