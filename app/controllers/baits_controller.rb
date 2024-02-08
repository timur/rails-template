class BaitsController < ApplicationController

  def index
    @baits = Bait.search(params)
  end

end
