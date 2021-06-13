class FtpDownloaderJob < ApplicationJob
  queue_as :default
  require 'net/ftp'
  require 'fileutils'



  def perform(downloader)



    download_source = Downloader.find(downloader)
    logger.info "setting downloader to processing"

    logger.debug "#{download_source.processing_status}"
    download_source.processing_status = "true"

    logger.debug "setting job start time"
    download_source.start_time = Time.now
    download_source.save
    logger.debug "setting downloader with ID #{downloader} processing set to #{download_source.processing_status.to_s}"

    logger.info "Starting downloader"
    logger.debug "FTP Instance name: #{download_source.setting.instance_name}"
    ftp = Net::FTP.new
    ftp.connect(download_source.setting.ftp_server, download_source.setting.ftp_port)
    ftp.login(download_source.setting.username, download_source.setting.ftp_password)
    ftp.chdir(download_source.ftp_path)
    ftp.passive = true
    file_list = ftp.nlst
    if download_source.rename == true
      logger.debug "renaming is enabled"
      final_path = "Mounts/PRX/#{download_source.rename_prefix}"
    else
      logger.debug "rename dissabled, saving to mounts without prefix."
      final_path = "Mounts/PRX/"
    end



    file_list.each do |file|
      logger.debug "found file #{file}"
      date_modified = ftp.mdtm(file)
      logger.debug "last modified (unix time): #{date_modified} "
      if FileListing.find_by(file_name: file).present?
        logger.info "file (#{file}), found in databse."
        if FileListing.find_by(file_name: file).last_modified < date_modified
          logger.info "^^#{file} is newer on FTP source than in our databse, downloading updated file"
          logger.debug "file is #{download_source.setting.instance_name} / #{download_source.ftp_path}/#{file}"
          ftp.getbinaryfile(file, "public/downloads/#{file}")
          DownloadLogger.info "downloaded #{file} at #{Time.now} - FTP Newer"
          logger.debug "downloaded, moving file to #{final_path}#{file}"
          logger.debug "sleeping for 3 seconds"
          sleep 3
          FileUtils.cp("public/downloads/#{file}", "#{final_path}#{file}")
          logger.debug "updating file_listings database with new date modified"
          filedata = FileListing.find_by(file_name: file)
          filedata.last_modified = date_modified
          logger.debug "saving database entry"
          filedata.save

        end
      else
        logger.debug "new file, downloading #{file}"
        ftp.getbinaryfile(file, "public/downloads/#{file}")
        DownloadLogger.info "downloaded #{file} at #{Time.now} - Never before seen"
        logger.info  "new file downloaded #{file}"
        logger.debug "sleeping for 3 seconds"
        sleep 3
        FileUtils.cp("public/downloads/#{file}", "#{final_path}#{file}")
        logger.debug "creating new file listing"
        filedata = FileListing.new
        filedata.file_name = file
        filedata.last_modified = date_modified
        logger.info "saving new file listing"
        filedata.save
      end
    end
    logger.info "closing FTP session!"
    ftp.close
    logger.info "removing processing_status"

    #logger.debug download_source.processing_status
    download_source.processing_status = "false"
    download_source.save
    #dl_status = download_source.processing_status.to_s
    logger.debug "setting downloader with ID #{downloader} processing set to #{download_source.processing_status.to_s}"

  end
  logger.info "Done with FTP downloading Job"
  puts "DONE!"


end
