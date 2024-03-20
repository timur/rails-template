class Examples::AhoyController < ApplicationController

  def index
    @events = EventAggregatorService.new.aggregate_events
  end

end
