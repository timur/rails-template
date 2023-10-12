class HomeController < ApplicationController
  include ActionView::Helpers::AssetTagHelper

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
    link = stylesheet_link_tag "tailwind"
    render json: {
      imports: {
        "@lodash/startCase" => ActionController::Base.helpers.asset_path("tailwind")
      }
    }
  end
end
