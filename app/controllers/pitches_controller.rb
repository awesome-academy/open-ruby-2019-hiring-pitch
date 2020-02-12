class PitchesController < ApplicationController
  def show
    @pitch = Pitch.find_by id: params[:id]
    @comment = Comment.new
    @rating = Rating.new
    @comments = Comment.comment_desc.where(id: UserPitchReaction
      .where(reactions_type: Comment.name, pitch_id: params[:id]).pluck(:reactions_id))

    return if @pitch
    flash[:danger] = t ".not_found"
    redirect_to root_url
  end
end
