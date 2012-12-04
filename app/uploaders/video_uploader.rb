# encoding: utf-8

class VideoUploader < CarrierWave::Uploader::Base
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
  
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}"
  end

  process :set_content_type

  def extension_white_list
    %w(mp4 m4v)
  end

  def filename
    if original_filename
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      "#{@name}.#{file.extension}"
    end
  end
end