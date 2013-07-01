module SessionHelper
  def session_user
    @session_user ||= FactoryGirl.create(:user)
  end
end
