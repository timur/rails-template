class ApplicationController < ActionController::Base
  before_action :set_current_request_details
  before_action :authenticate

  around_action :set_time_zone
  include Pagy::Backend

  def set_time_zone
    Time.use_zone(cookies[:time_zone]) { yield }
  end

  private
    def authenticate
      if session_record = Session.find_by_id(cookies.signed[:session_token])
        Current.session = session_record
      else
        redirect_to sign_in_path
      end
    end

    def set_current_request_details
      Current.user_agent = request.user_agent
      Current.ip_address = request.ip
    end

    def track_action
      ahoy.track 'Ran action',
                 request.path_parameters
    end
end
