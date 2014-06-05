module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    # create a new token
    # new_remember_token method defined in models/user.rb
     if params[:remember_me]
    cookies.permanent[:remember_token] = remember_token
     else 
     cookies[:remember_token] = remember_token
     end
    # place the raw token in the browser cookies
    user.update_attribute(:remember_token, User.digest(remember_token))
    # save the hashed token to the database
    self.current_user = user
    # set the current user equal to the given user 
    # setting the current user to user isn’t currently necessary because of the immediate redirect in the create action, but it’s a good idea in case we ever want to use sign_in without a redirect.
  end
  
   def current_user=(user)
    @current_user = user
  end
  
    def current_user
    remember_token = User.digest(cookies[:remember_token])
      @current_user ||= User.find_by(remember_token: remember_token) if cookies[:remember_token]
  end
  
    def current_user?(user)
    user == current_user
  end
  
   def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  # :return_to = Home page with sign up
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    flash[:succuess] = "You have successfully logged in!"
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
  
  
  
  
end