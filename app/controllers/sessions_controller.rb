class SessionsController < ApplicationController
  def new
  end
  
  def create
    human = Human.find_by(name: params[:session][:email].downcase)
    if human && human.authenticate(params[:session][:password])
      log_in user
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
