# encoding: utf-8

class ArticleHeroUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/articles/#{mounted_as}/#{model.id}"
  end
end