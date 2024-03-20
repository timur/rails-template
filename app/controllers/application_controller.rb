class ApplicationController < ActionController::Base
  after_action :track_action

  around_action :set_time_zone
  include Pagy::Backend  

  def set_time_zone
    Time.use_zone(cookies[:time_zone]) { yield }
  end

  protected

  def track_action
    ahoy.track 'Ran action',
               request.path_parameters
  end
end
