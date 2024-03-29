class Users::RegistrationsController < Devise::RegistrationsController
respond_to :js
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]
skip_before_action :require_no_authentication, only: [:new, :create, :cancel]
private

  def sign_up_params
    params.require(:user).permit(:nome,:cpf, :telefone, :endereco, :type, :matricula, :bday, :sex, :marital_status, :city, :state, :avatar, :email , :password, :password_confirmation, :course_id, :institution_id)
  end

  def account_update_params
    params.require(:user).permit(:nome,:cpf, :telefone, :endereco, :type, :matricula, :bday, :sex, :marital_status, :city, :state ,:avatar, :email , :password, :password_confirmation, :course_id, :institution_id, :current_password)
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
   def configure_sign_up_params
       devise_parameter_sanitizer.permit(:sign_up, keys: [:nome,:cpf, :telefone, :endereco, :type, :matricula, :bday, :sex, :marital_status, :city, :state , :avatar, :email , :password, :password_confirmation, :course_id, :institution_id])
   end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(user)
    # super(user)
   #end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
