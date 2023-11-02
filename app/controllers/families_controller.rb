class FamiliesController < ApplicationController

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
    @family = Family.new(session["family.regist_data"])
    binding.pry
    @user = User.new(user_params)
      unless @user.valid?
        render :new_user, status: :unprocessable_entity and return
      end
    @family.users.build(@user.attributes)
    @family.save
    session["family.regist_data"].clear
    sign_in(:family, @family)

    redirect_to root_path
  end

  private

  def family_params
    params.require(:family).permit(:name)
  end

  def user_params
    params.require(:user).permit(:name)
  end

end
