class MixSound < ApplicationRecord
  belongs_to :sound
  belongs_to :mix

  # accepts_nested_attributes_for :sound
end
