class Rating < ApplicationRecord
  has_many :user_pitch_reactions, as: :reactions
  belongs_to :pitch, optional: true

  validates :star, numericality: {greater_than_or_equal_to: 1}
end
