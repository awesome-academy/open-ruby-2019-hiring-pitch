class RatingsController < ApplicationController
  before_action :load_pitch, only: :create
  before_action :logged_in_user, only: :create

  def create
    @rating =  Rating.new star: params[:star]

    if @rating.save
      @rating.user_pitch_reactions.create(user: current_user, pitch: @pitch)
      flash[:success] =  t ".successful"
      respond_to :html, :js
    else
      flash[:danger] =  t ".fail"
    end
    redirect_to request.referrer || root_url
  end

  private

  def load_pitch
    @pitch = Pitch.find_by id: params[:pitch_id]

    return if @pitch
    flash[:danger] = t ".not_found"
    redirect_to root_url
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = t ".loggin"
    redirect_to login_url
  end
end
