class SignupsController < ApplicationController
  before_action :validates_registration, only: :phone
  before_action :validates_address, only: :credit
  
  def registration
    @user = User.new
    @user.build_personal_information
  end

  def phone
    @user = User.new
    @user.build_personal_information
    user_params[:personal_information_attributes][:birth] = birthday
    session[:birth] = birthday
    session[:dummylongcode] = "1111111"
    session[:dummyshortcode] = "10"
    params[:user][:personal_information_attributes][:postal_code] = session[:dummylongcode]
    params[:user][:personal_information_attributes][:prefecture_id] = session[:dummyshortcode]
    params[:user][:personal_information_attributes][:city] = session[:dummyshortcode]
    params[:user][:personal_information_attributes][:address] = session[:dummyshortcode]
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:personal_information_attributes] = user_params[:personal_information_attributes]
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation]
    )
    @user.build_personal_information(session[:personal_information_attributes])

  end
  
  def address
    @user = User.new
    @user.build_personal_information
  end

  def credit
    @user = User.new
    @user.build_personal_information
    @creditcard = CreditCard.new

  end

  def create
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation]
    )
    @user.build_personal_information
    @user.build_personal_information(session[:personal_information_attributes])
    if @user.save
      session[:id] = @user.id
      redirect_to done_signups_path
    else
      render "/signups/credit"
    end
  end

  def done
    sign_in User.find(session[:id]) unless user_signed_in?
  end

  private
  def user_params
    params.require(:user).permit(:nickname,:email,:password, :password_confirmation, 
    personal_information_attributes:[:id, :user_id, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number])
  end

  def birthday
    date = user_params[:personal_information_attributes]
    date["birth(1i)"].to_s + "-" + date["birth(2i)"].to_s + "-" + date["birth(3i)"].to_s
    if date["birth(1i)"].empty? && date["birth(2i)"].empty? && date["birth(3i)"].empty?
      return
    end
    return date["birth(1i)"].to_s + "-" + date["birth(2i)"].to_s + "-" + date["birth(3i)"].to_s
  end

  def validates_registration
    session[:dummylongcode] = "1111111"
    session[:dummyshortcode] = "10"
    params[:user][:personal_information_attributes][:postal_code] = session[:dummylongcode]
    params[:user][:personal_information_attributes][:prefecture_id] = session[:dummyshortcode]
    params[:user][:personal_information_attributes][:city] = session[:dummyshortcode]
    params[:user][:personal_information_attributes][:address] = session[:dummyshortcode]
    session[:last_name] = user_params[:personal_information_attributes][:last_name]
    session[:first_name] = user_params[:personal_information_attributes][:first_name]
    session[:last_name_kana] = user_params[:personal_information_attributes][:last_name_kana]
    session[:first_name_kana] = user_params[:personal_information_attributes][:first_name_kana]
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:personal_information_attributes] = user_params[:personal_information_attributes]
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation]
    )
    @user.build_personal_information(session[:personal_information_attributes])
    @user.valid?
    if @user.errors.any?
      @error = @user.errors.full_messages_for(:base)
        render registration_signups_path
    end
  end

  def validates_address
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation]
    )
    @user.build_personal_information
    params[:user][:personal_information_attributes][:last_name] = session[:last_name]
    params[:user][:personal_information_attributes][:first_name] = session[:first_name] 
    params[:user][:personal_information_attributes][:last_name_kana] = session[:last_name_kana]
    params[:user][:personal_information_attributes][:first_name_kana] = session[:first_name_kana]
    params[:user][:personal_information_attributes][:birth] = session[:birth]
    session[:personal_information_attributes] = user_params[:personal_information_attributes]
    @user.build_personal_information(session[:personal_information_attributes])
    render address_signups_path unless @user.valid?
  end

end
