class SessionsController < ApplicationController
  def new
  end
  
  def create
    human = Human.find_by(email: params[:session][:email].downcase)
    if human && human.authenticate(params[:session][:password])
      log_in human
      redirect_to root_url, success: "ログインしました"
    else
      flash[:error] = "ログインに失敗しました"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, success: "ログアウトしました"
  end

end
