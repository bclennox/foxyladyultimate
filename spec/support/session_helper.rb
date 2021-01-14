module SessionHelper
  def session_user
    @session_user ||= create(:user)
  end
end
