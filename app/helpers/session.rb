
helpers  do

  def authorized?
    !!session[:user_id]
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logout
    session.clear
    redirect_home
  end

  def current_user_id
    session[:user_id]
  end

  def current_user_name
    @current_user.name
  end

  def redirect_home
    if authorized?
      redirect "/user/#{session_user_id}"
    else
      redirect '/'
    end
  end
end
