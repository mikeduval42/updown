class UsersController < ApplicationController
  respond_to :json, :html

  # /you.json give you the current user
  # def you
  #   respond_with current_user
  # end

    # /users.json
  def index
    @users = User.all
    respond_with @users
  end

  def show
    @user = User.find(params[:id])
    respond_with @user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      respond_to do |format|
        format.html {redirect_to outfits_path}
        format.json {render nothing: true, status: :no_content}
      end
    else
      respond_to do |format|
        format.html {render 'edit'}
        format.json {render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:remember_token] = @user.id
      @current_user = @user
      respond_to do |format|
        format.html {redirect_to outfits_path}
        format.json {render json: @user, status: :created}
      end
    else
      respond_to do |format|
        format.html {redirect_to 'new'}
        format.json {render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = user.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html {redirect_to :root}
      format.json {render json: {head: :ok}}
    end
  end

  protected

  def user_params
    params.require(:user).permit(:user_name, :name, :email, :password, :password_confirmation)
  end
end