class UsersController < ApplicationController
  def show
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:name, :introduction, :field, :link)
  end

end
