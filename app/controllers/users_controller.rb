class UsersController < ApplicationController
  #アクション
  def show
    @user = User.find(params[:id])
  end

end
