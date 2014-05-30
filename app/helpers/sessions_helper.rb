module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    # create a new token
    # new_remember_token method defined in models/user.rb
    cookies.permanent[:remember_token] = remember_token
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
    @current_user ||= User.find_by(remember_token: remember_token)
  end
  
   def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
end