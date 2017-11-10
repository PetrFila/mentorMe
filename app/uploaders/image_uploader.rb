class ImageUploader < Shrine
  require "./config/initializers/shrine"
  plugin :remove_attachment

end
