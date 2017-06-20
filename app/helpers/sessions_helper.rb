module SessionsHelper
  def current_user
    @_current_user ||= User.find_or_initialize_by(id: cookies.signed[:user_id])
  end

  def current_user?(user)
    @_current_user.id == user.id
  end

  def signed_in?
    cookies.signed[:user_id] != nil
  end

  def create_session_for(user, expires: 24.hours.from_now)
    cookies.signed[:user_id] = { value: user.id, expires: expires }
  end

  def create_permanent_session_for(user)
    cookies.permanent.signed[:user_id] = user.id
  end

  def reset_session
    cookies.signed[:user_id] = nil
  end
end
