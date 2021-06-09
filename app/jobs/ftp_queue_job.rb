class FtpQueueJob < ApplicationJob
  queue_as :default

  def perform(priority)
    logger.info "got job with priority #{priority}"
    Downloader.all.each do |dl_source|
      if dl_source.interval == priority
        if dl_source.processing_status == false
        logger.debug "#{dl_source.ftp_path} download requested"
        dl_id = dl_source.id
        logger.debug "moving job to downloader"
        FtpDownloaderJob.perform_later(dl_id)
        else
          logger.info "already running job for #{dl_source.ftp_path}"
        end
      else
        logger.info "#{dl_source.ftp_path} is not needed at this time"
      end
    end
  end
end
