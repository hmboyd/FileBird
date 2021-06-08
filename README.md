# FileBird - FTP manager for broadcast services

# WARNING THE PASSWORD IS STORED IN PLAIN TEXT IN THIS APPLICATION!
## I really should fix it...but thats more work.

# setup

app can be deployed with capistrano

1. make your server
2. Set database.yml with your info (we're using postgresql)
3. navigate to server after app is online and enter in an ftp server /settings
4. navigate to /downloaders and enter in some info
  1. you need a leading slash (/) on the FTP file path
