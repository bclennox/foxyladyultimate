class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def update
    if current_user.update(profile_params)
      redirect_to edit_profile_path, notice: 'Your profile has been updated.'
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def profile_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
