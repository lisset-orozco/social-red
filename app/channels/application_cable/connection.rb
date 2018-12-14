module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_user
    end

    def find_user
      user ? user : reject_unauthorized_connection
    end

    def user
      user_id = cookies.signed["user.id"]
      @user ||= User.find_by(id: user_id)
    end
  end
end
