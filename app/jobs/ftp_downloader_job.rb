class FtpDownloaderJob < ApplicationJob
  queue_as :default
  require 'net/ftp'
  require 'fileutils'



  def perform(downloader)
    download_source = Downloader.find(downloader)
    print "~~~~~~~~~~~~$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$~~~~~~~~~~~~~~~~"
    print download_source.setting.instance_name
    ftp = Net::FTP.new
    ftp.connect(download_source.setting.ftp_server, download_source.setting.ftp_port)
    ftp.login(download_source.setting.username, download_source.setting.ftp_password)
    ftp.chdir(download_source.ftp_path)
    ftp.passive = true
    file_list = ftp.nlst
    if download_source.rename == true
      final_path = "Mounts/PRX/#{download_source.rename_prefix}"
    else
      final_path = "Mounts/PRX/"
    end



    file_list.each do |file|
      puts file
      date_modified = ftp.mdtm(file)
      puts date_modified
      if FileListing.find_by(file_name: file).present?
        puts "found file in database!"
        if FileListing.find_by(file_name: file).last_modified < date_modified
          puts "Downloading!!"
          ftp.getbinaryfile(file, "public/downloads/#{file}")
          FileUtils.mv("public/downloads/#{file}", "#{final_path}#{file}")
          puts "UPDATING DATE MODIFIED!"
          filedata = FileListing.find_by(file_name: file)
          filedata.last_modified = date_modified
          filedata.save

        end
      else
        ftp.getbinaryfile(file, "public/downloads/#{file}")
        puts "sleeping for 2 seconds"
        sleep 3
        FileUtils.mv("public/downloads/#{file}", "#{final_path}#{file}")
        filedata = FileListing.new
        filedata.file_name = file
        filedata.last_modified = date_modified
        filedata.save
      end
    end
    ftp.close
  end
  puts "DONE!"
end
