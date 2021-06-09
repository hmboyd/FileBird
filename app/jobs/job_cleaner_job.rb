class JobCleanerJob < ApplicationJob
  queue_as :default

  def perform
    logger.info "JOB CLEANUP STARTED"
    logger.debug "checking for stuck jobs"
    Downloader.all.each do |dlr|
      if dlr.start_time.present? && dlr.processing_status == true
        logger.debug "found possibly stuck job, checking start time"
        time_diff = (Time.current - dlr.start_time)
        time_diff_min = (time_diff / 1.minute).round
        logger.debug "time since job started is #{time_diff_min} min"
        if time_diff_min > 15
          logger.debug "job is too old removing job status"
          dlr.processing_status = false
          dlr.save
          logger.info "suck job status cleared"
        else
          logger.info "job for #{dlr.ftp_path} is current, probably running on a 15min interval"
        end

      else
        logger.info "job #{dlr.ftp_path} is not stuck, no need to cleanup"
      end
    end
  end
end
