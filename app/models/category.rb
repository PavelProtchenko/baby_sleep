class Category < ApplicationRecord
  attr_accessor :categorization_attributes
  has_many :category_sounds
  has_many :sounds, through: :category_sounds
  has_many :mix_categories
  has_many :mixes, through: :mix_categories

  accepts_nested_attributes_for :sounds, allow_destroy: true
  accepts_nested_attributes_for :category_sounds, allow_destroy: true
  accepts_nested_attributes_for :mixes, allow_destroy: true

  validates :title, presence: true
  mount_uploader :image_url, CategoryImageUploader
  mount_uploader :main_image_url, CategoryMainImageUploader
end
