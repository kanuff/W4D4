class BandsController < ApplicationController




  def new
    @band = Band.new
    render :new
  end

  def create
    band = Band.new(band_params)
    if band.save
      redirect_to bands_url
    else
      flash.now[:errors] = band.errors.full_messages
      render :new
    end
  end

  def show
    @band = Band.find_by(id: params[:id])
    if @band
      render :show
    else
      flash.now[:errors] = ["Band has not been banded yet"]
      render :new
    end
  end

  def index
    @bands = Band.all
    render :index
  end

  def update
    band = Band.update(band_params)
    if band.save
      redirect_to band_url(band)
    else
      flash.now[:errors] = ["Never heard of them"]
      render :edit
    end
  end

  def edit
    @band = Band.find_by(id: params[id])
    render :edit
  end

  def destroy
    band = Band.find_by(id: params[:id])
    if band
      band.destroy
    end
    redirect_to bands_url
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end

end