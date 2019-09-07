class Mix < ApplicationRecord
  has_many :mix_sounds
  has_many :sounds, through: :mix_sounds
  has_many :mix_categories
  has_many :categories, through: :mix_categories #, dependent: :destroy

  validates :name, presence: true

  # mount_uploader :image_url, MixImageUploader

  accepts_nested_attributes_for :sounds, allow_destroy: true
  accepts_nested_attributes_for :categories
  # accepts_nested_attributes_for :mix_categories, allow_destroy: true

  def self.search(term)
    if term
      where('name LIKE ?', "%#{term}%")
    else
      all
    end
  end
end
