class ArtistsController < ApplicationController
  def index
    if params[:song_id]
      @song = Song.find_by(id: params[:song_id])
      if @song.nil?
        redirect_to songs_path, alert: "Song not found"
      else
        @artist = @song.artists
      end
    else
      @artists = Artist.all
    end
  end

  def show
    if params[:song_id]
      @song = Song.find_by(id: params[:song_id])
      @artist = @song.artist.find_by(id: params[:id])
      if @artist.nil?
        redirect_to song_artist_path(@song), alert: "Artist not found"
      end
    else
      @artist = Artist.find(params[:id])
    end
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :new
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])

    @artist.update(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :edit
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:notice] = "Artist deleted."
    redirect_to artists_path
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :song_name, :song_id)
  end
end
