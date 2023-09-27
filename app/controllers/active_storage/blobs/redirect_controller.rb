  class ActiveStorage::Blobs::RedirectController < ActiveStorage::BaseController
    include ActiveStorage::SetBlob

    def show
      b = ActiveStorage::Blob.find_signed(params[:signed_blob_id] || params[:signed_id])

      logger.debug "ActiveStorage::Blobs::RedirectController#show FROM HELL #{b.inspect}" 

      expires_in ActiveStorage.service_urls_expire_in
      redirect_to @blob.url(disposition: params[:disposition]), allow_other_host: true
    end
  end