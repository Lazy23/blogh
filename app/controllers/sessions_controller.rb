class SessionsController < ApplicationController
  # GET /login
  def new
    # render :new
  end

  # POST /login
  def create
    if sessions_is_authenticated?
      redirect_to home_url, notice: 'Successfuly logged in'
    else
      redirect_to login_url, notice: 'Invalid email/password combination'
    end
  end

  # DELETE /logout
  def destroy
    reset_session
    redirect_to home_url, notice: 'Logged out'
  end

  private

  def sessions_is_authenticated?
    user = User.find_by(email: params[:email])
    return false unless user && user.authenticate(params[:password])

    if params[:remember_me]
      create_permanent_session_for(user)
    else
      create_session_for(user)
    end
  end
end
