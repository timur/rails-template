class ApplicationController < ActionController::Base
  around_action :set_time_zone

  def set_time_zone
    Time.use_zone(cookies[:time_zone]) { yield }
  end
end
