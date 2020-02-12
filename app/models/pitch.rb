class Pitch < ApplicationRecord
  belongs_to :user
  has_many :user_pitch_reactions, class_name: UserPitchReaction.name
  has_many :bookings
  has_many :comments
  has_many :ratings

  scope :create_at_desc, -> {order created_at: :desc}
  scope :search_pitch, ->search{where("description LIKE ?", "%#{search}%").or where("address LIKE ?","%#{search}%")}

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
