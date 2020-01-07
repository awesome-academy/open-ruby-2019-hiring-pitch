class Pitch < ApplicationRecord
  belongs_to :user
  has_many :user_pitch_reactions, as: :user_pitch_reactionable
  scope :created_at, -> {order(created_at: :desc)}

  enum status: {disable: 0, enable: 1}
  mount_uploader :image, ImageUploader
  validate :image_size
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :action_time

  PITCH_PARAMS = %i(description address image start_time end_time price status).freeze
  SELECT_HOME = %i(id description address image start_time end_time price status).freeze

  private

  def image_size
    return unless image.size > Settings.users.avatar_size.size.megabytes
    errors.add :image, I18n.t("error")
  end

  def action_time
    return unless start_time || end_time
    return if start_time < end_time
    errors.add :start_time, I18n.t(".error")
  end
end
