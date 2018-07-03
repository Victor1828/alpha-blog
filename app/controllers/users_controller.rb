class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.order(:username).paginate(page: params[:page], per_page: 2)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.username = @user.username.titleize
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Congrats! #{@user.username}, welcome to the Alpha Blog"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = "User updated correctly"
      redirect_to articles_path
    else
      render :edit
    end
  end

  def show; end

  def destroy
    @user.destroy
    flash[:success] = "User and all of his articles have been deleted"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if (current_user != @user) && !current_user.admin?
      flash[:danger] = "You can only edit your account"
      redirect_to articles_path
    end
  end
end
