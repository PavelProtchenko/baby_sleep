class Picture < ApplicationRecord
  mount_uploader :body_image_url, BodyImageUploader
end
