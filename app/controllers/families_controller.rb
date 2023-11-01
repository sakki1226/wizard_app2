class FamiliesController < ApplicationController
  def new
    @family = Family.new
  end

  def create
    @family = Family.new
     unless @family.valid?
       render :new, status: :unprocessable_entity and return
     end
    session["family.regist_data"] = {family: @family.attributes}
    binding.pry
    session["family.regist_data"][:user]["password"] = params[:user][:password]
    binding.pry
    @user = @family.build_user
    render :new_user, status: :accepted
  end

  def create_user
    @family = Family.new(session["family.regist_data"])
    @user = User.new(user_params)
      unless @user.valid?
        render :new_user, status: :unprocessable_entity and return
      end
    @family.build_user(@user.attributes)
    @family.save
    session["devise.regist_data"]["family"].clear
    sign_in(:family, @family)

    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

end
