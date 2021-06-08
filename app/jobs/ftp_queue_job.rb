class FtpQueueJob < ApplicationJob
  queue_as :default

  def perform(priority)
    Downloader.all.each do |dl_source|
      if dl_source.interval == priority
        puts "#{dl_source.ftp_path} download requested"
        dl_id = dl_source.id
        FtpDownloaderJob.perform_later(dl_id)
      else
        puts "#{dl_source.ftp_path} is not needed at this time"
      end
    end
  end
end
