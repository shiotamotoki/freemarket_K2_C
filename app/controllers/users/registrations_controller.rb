# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  
  # before_action :configure_account_update_params, only: [:update]
  


  def before_signup
  end

  #   # POST /resource
  #  def create
  #    super
  #  end

   def new
    @user = User.new
    @user.build_personal_information
   end

   def new2
   end

   def new3
   end

   def new4
   end

   def new5
   end
  
    private

    def user_params
      params.require(:user).permit(:nickname, personal_information_attributes:[:id, :user_id, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth, :zip_code, :prefecture, :city, :address, :building_name, :phone_number])
    end




  
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
