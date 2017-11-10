# require "shrine"
# require "shrine/storage/file_system"
#
# Shrine.storages = {
#   cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
#   store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"), # permanent
# }
#
# Shrine.plugin :activerecord
# Shrine.plugin :cached_attachment_data # for forms
# Shrine.plugin :rack_file # for non-Rails apps


#CLOUDINARY setup

# require "cloudinary"
# require "shrine/storage/cloudinary"
#
# Cloudinary.config(
#   cloud_name: "profile-avatar",
#   api_key:    "514873724659967",
#   api_secret: "xbRguaO6FbUnwfcvKyUfQ4rNQxk"
# )
#
# Shrine.storages = {
#   cache: Shrine::Storage::Cloudinary.new(prefix: "cache"), # for direct uploads
#   store: Shrine::Storage::Cloudinary.new(prefix: "store"),
# }


#AWS S3 setup
require "shrine/storage/s3"

s3_options = {
    access_key_id:      ENV['S3_KEY'],
    secret_access_key:  ENV['S3_SECRET'],
    region:             ENV['S3_REGION'],
    bucket:             ENV['S3_BUCKET'],
}


# Shrine.storages = {
#     cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
#     store: Shrine::Storage::S3.new(prefix: "store", **s3_options),
# }




Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
  store: Shrine::Storage::S3.new(prefix: "store", **s3_options),
}
