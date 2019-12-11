class Owner::PitchesController < OwnerController
  before_action :load_pitch, only: %i(edit update)
  before_action :correct_user, only: :destroy

  def index
    @pitches = current_user.pitches.created_at.page(params[:page]).per Settings.perpage
  end

  def new
    @pitch = Pitch.new
  end

  def create
    @pitch = current_user.pitches.build pitch_params

    if @pitch.save
      redirect_to owner_pitches_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @pitch.update_attributes pitch_params
      flash[:success] = t ".success"
      redirect_to owner_pitches_path
    else
      flash[:danger] =  t".not_update"
      render :edit
    end
  end

  def destroy
    @pitch.destroy
    if @pitch.destroyed?
      flash[:success] = t ".delete_pitch"
      redirect_to request.referrer || root_url
    else
      flash[:danger] =  t".not_deleted"
      redirect_to request.referrer || root_url
    end
  end

  private

  def pitch_params
    params.require(:pitch).permit Pitch::PITCH_PARAMS
  end

  def load_pitch
    @pitch = Pitch.find_by id: params[:id]

    return if @pitch
    flash[:danger] = t ".not_found"
    redirect_to owner_pitches_path
  end

  def correct_user
    @pitch = current_user.pitches.find_by id: params[:id]
    redirect_to owner_pitches_path unless @pitch
  end
end
