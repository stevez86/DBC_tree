helpers do
  def user_from_id(user_id)
    User.find(user_id)
  end
end
