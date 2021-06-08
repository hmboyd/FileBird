json.extract! file_listing, :id, :file_name, :file_path, :last_modified, :created_at, :updated_at
json.url file_listing_url(file_listing, format: :json)
