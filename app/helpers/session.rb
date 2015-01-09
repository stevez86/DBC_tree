
helpers  do

  def authorized?
    !!session[:user_id]
  end

  def login(user)
    session[:user_id] = user.id
    # session[:user_name] = user.name
  end

  def logout
    session.clear
  end
end
