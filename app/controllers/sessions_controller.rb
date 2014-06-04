class SessionsController < ApplicationController
  
  def new
    render 'new'
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
  if user && user.authenticate(params[:session][:password])
   
      sign_in user
    # sign_in method defined in helpers/sessions_helper.rb
      redirect_back_or user
  else
    # Create an error message and re-render the signin form.
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
  end
end
  
   def destroy
     # methods defined in sessions_helper
     sign_out
     redirect_to root_url, notice: "You have successfully logged out!"
  end
 
end
