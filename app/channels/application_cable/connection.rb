module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    def connect
      self.current_user = find_verified_user
    end
    private
    def find_verified_user
      return current_user if current_user && current_user.verified?

      reject_unauthorized_connection
    end
  end
end
