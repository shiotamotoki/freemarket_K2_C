class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :basic_auth, if: :production?  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_categories
  # before_action :authenticate_user! 


  def set_categories
    @parents = Category.where(ancestry: nil) 
  end
  
  protected


  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, personal_information_attributes: [:id, :user_id, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number]])
  end


  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end



  def sign_in_user
    redirect_to new_user_session_path unless user_signed_in?
  end


end
