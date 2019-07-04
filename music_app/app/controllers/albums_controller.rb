class AlbumsController < ApplicationController


  def new
    @album = Album.new(band_id: params[:band_id])
    render :new
  end

  def create
    @album = Album.new(
      band_id: params[:album][:band_id],
      title: params[:album][:title],
      yr: params[:album][:yr],
      studio: params[:album][:studio]
      )
    if @album.save
      redirect_to band_url(@album.band)
    else
      @album.band_id = Band.first.id
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def show
    # @album = Album.new(band_id: params[:band_id])
    render :show
  end
end