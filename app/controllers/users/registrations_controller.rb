# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController


  def index
  end

  def new
    @family = Family.new
  end

  def create
    @family = Family.new(family_params)
     unless @family.valid?
       render :new, status: :unprocessable_entity and return
     end
    session["family.regist_data"] = {family: @family.attributes}
    @user = @family.users.build
    render template: 'devise/registrations/new_user', status: :accepted
  end

  def create_user
    @family = Family.new(session["family.regist_data"]["family"])
    @user = User.new(user_params)
      unless @user.valid?
        render :new_user, status: :unprocessable_entity and return
      end
    @user = @family.users.build(user_params)
    @family.save
    session["family.regist_data"].clear
    sign_in(:user, @user)

    redirect_to root_path
  end

  private

  def family_params
    params.require(:family).permit(:name)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

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
