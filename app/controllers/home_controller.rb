class HomeController < ApplicationController
  def index
    json_data = Rails.application.importmap.to_json(resolver: ActionController::Base.helpers)
    data = JSON.parse(json_data)
    data["imports"].each do |key, value|
      if value.start_with?('/assets')
        data["imports"][key] = "http://localhost:3000" + value
      end
    end
    render json: data
  end

  def map
    render json: {
      imports: {
        "@lodash/startCase" => "https://unpkg.com/lodash-es@4.17.21/startCase.js"
      }
    }
  end
end
