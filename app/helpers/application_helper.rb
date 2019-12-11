module ApplicationHelper
  def full_title page_title = ""
    base_title = t".base_title"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end  

  def get_image object
    object.avatar? ? object.avatar.url: Settings.helper.avatar
  end

  def get_image_pitch pitch
    pitch.image? ? pitch.image.url: Settings.helper.image
  end

  def get_image_pitch pitch
    image_tag(pitch.image? ? pitch.image.url : Settings.helper.image)
  end

  def pitch_status_option
    Pitch.statuses.map do |key, value|
      [t(".owner.pitches.form.#{key}"), key] 
    end
  end
end
