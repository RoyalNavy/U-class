class UsersController < ApplicationController
    before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
    before_action :correct_user,   only: [:edit, :update]
    before_action :admin_user,     only: :destroy


  def show
    @projects = User.search(params[:search])
    @user =User.find(params[:id])
  end
  
    def new
      @user = User.new
  end
  
  def index
<<<<<<< HEAD
    @users = User.search(params[:search])
    @users = User.paginate(page: params[:page])
=======
    
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order('created_at DESC')
      @users = User.paginate(page: params[:page])
>>>>>>> before-search
  end
   
end
    
 

  
  def edit
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  
 def create
    @user = User.new(user_params)
    if @user.save
       sign_in @user
      flash[:success] = "Welcome to the U-Class!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
# Before filters

     def signed_in_user
    unless signed_in?
        store_location
      redirect_to signin_url, notice: "Please sign in."
     end
     end
 
     def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  
  def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end

  

