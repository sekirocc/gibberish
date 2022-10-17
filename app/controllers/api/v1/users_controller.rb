class Api::V1::UsersController < ApplicationController

  def index
    @users = User.all
    render json: @users
    # respond_to do |format|
    #   format.json
    # end
  end

  def show
    @user = User.find(params[:id])
    render json: @user
    # respond_to do |format|
    #   format.json
    # end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: { error: 'cannot create user' }
    end
  end

  def update
    @user = User.find(params[:id])
    if @user
      @user.update(user_params)
      render json: @user
    else
      render json: { error: 'not found user', status: 404 }
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      @user.destroy
      render json: { message: 'destroy success', status: 200}
    else
      render json: { error: 'not found user', status: 404 }
    end
  end

  def user_params
    params.require(:user).permit(
      :nickname,
      :birthday,
      :gender,
      :status,
      :username,
      :password_hash,
      :email,
      :email_confirmed,
      :mobile,
      :wechat,
      :weibo,
      :avatar_url,
      :member_since,
      )
  end

end
