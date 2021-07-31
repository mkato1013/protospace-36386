class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @prototypes = @user.prototypes
  end

  #def user_params
  #  params.require(:user).permit(:name, :profile, :occupation, :position).merge(prototype_id: params[:prototype_id])
  #end

end
