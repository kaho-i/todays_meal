class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  before_action :is_login_user?, only: [:edit, :update, :check, :withdraw]
  
  def mypage
    @user = current_user
    @posts = @user.posts.all.page(params[:page]).per(10)
  end

  def index
    @users = User.all.page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  def check
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_active: false)
    reset_session
    redirect_to root_path
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :email, :profile_image)
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
  
  def is_login_user?
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to mypage_path
    end
  end
end
