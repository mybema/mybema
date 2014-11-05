# encoding: utf-8

class AllDiscussionsImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/app_settings"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "bulb.png"
  end
end