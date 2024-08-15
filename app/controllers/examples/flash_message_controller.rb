class Examples::FlashMessageController < ApplicationController
  def create
    message_type = params[:message_type] || :info
    respond_to do |format|
      format.html do 
        redirect_to examples_snippets_flashes_path, notice: { title: 'Title vom normalen HTML', message: params[:message] }
      end
      format.turbo_stream { flash.now[message_type] = { title: "Titel vom Turbo Stream", message: params[:message] } }
    end
  end
end