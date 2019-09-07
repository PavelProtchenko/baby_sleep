class AudioUploader < CarrierWave::Uploader::Base
  include CarrierWave::Audio

  def extension_white_list
    %w[mp3 wav]
  end

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s}#{mounted_as}"
  end
end
