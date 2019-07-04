class TracksController < ApplciationController


  def new
    @track = Track.new(album_id: params[:album_id])    
    render :new
  end

end
