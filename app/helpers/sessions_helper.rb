module SessionsHelper
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      return unless @current_user = User.find_and_authenticate(user_id, cookies[:remember_token])
      log_in @current_user
    end
  end

  def log_in(user)
    session[:user_id] = user.id
    remember(user)
  end

  def logged_in?
    !!current_user
  end

  def log_out
    forget_current_user
    session.delete(:user_id)
    @current_user = nil
  end

  private

  def remember(user)
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget_current_user
    current_user.regenerate_remember_token
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
