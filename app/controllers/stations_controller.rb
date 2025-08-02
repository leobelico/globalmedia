class StationsController < ApplicationController
  before_action :set_station, only: [:show, :edit, :update, :destroy]
  before_action :set_station_on_id, only: [:articles]
  before_action :prepare_s3_upload, only: [:new, :edit]

  def index
    @radio_programs = Station.where(video: false, news: false).order(:frequency)
    @video_programs = Station.where(video: true).order(:frequency)
    @news_channels = Station.where(news: true).order(:frequency)
  end

  def show
    session[:article_id] = nil

    if params[:tag]
      redirect_to search_results_path(params[:tag]) and return
    end

    @https_src = "https://59dcdb8f833ed.streamlock.net:443/Shoutcast/#{@station.stream_url}.stream/playlist.m3u8"
    @rtmps_src = "rtmps://59dcdb8f833ed.streamlock.net:443/Shoutcast/#{@station.stream_url}.stream"
    @recommendations = Station.where.not(id: @station.id).where(news: false).order(id: :desc).limit(7)

    time = Time.current
    weekday = time.strftime("%A").downcase
    @timetables = Timetable.for_station_now(@station.id, weekday, time).order(:streaming_hour).limit(5)
  end

  def new
    @station = Station.new
    21.times { @station.timetables.build }
  end

  def edit
    21.times { @station.timetables.build } if @station.timetables.size < 21
  end

  def create
    clean_duplicate_ids
    @station = Station.new(station_params)

    if @station.save
      @station.update(slug: @station.slug)
      redirect_to panel_station_path(@station), notice: "Estación creada correctamente."
    else
      prepare_s3_upload
      render :new
    end
  end

  def update
    clean_duplicate_ids

    if @station.update(station_params)
      redirect_to panel_station_path(@station), notice: "Estación actualizada correctamente."
    else
      render :edit
    end
  end

  def destroy
    @station.destroy
    redirect_to panel_stations_path, notice: "Estación eliminada correctamente."
  end

  def articles
    @relationships = @station.article_relationships.paginate(page: params[:page], per_page: 12)
  end

  private

  def set_station_on_id
    @station = Station.find_by(slug: params[:station_id])
    unless @station
      flash[:alert] = "No encontramos lo que estabas buscando"
      redirect_to root_url
    end
  end

  def set_station
    @station = Station.find_by("slug ILIKE ?", params[:id])
    unless @station
      flash[:alert] = "No encontramos lo que estabas buscando"
      redirect_to root_url
    end
  end

  def station_params
    raw = params.require(:station).permit(
      :name, :frequency, :description,
      :playlist_1, :playlist_2, :playlist_3, :playlist_4,
      :playlist_1_image, :playlist_2_image, :playlist_3_image, :playlist_4_image,
      :stream_url, :app_url, :facebook, :twitter,
      :video, :news, :image, :image_preview,
      timetables_attributes: [
        :id, :name, :broadcasters, :description,
        :streaming_hour, :end_streaming_hour,
        :monday, :tuesday, :wednesday, :thursday,
        :friday, :saturday, :sunday,
        :image, :broadcaster_image, :_destroy
      ]
    )

    if raw[:timetables_attributes]
      raw[:timetables_attributes].each { |_, tt| tt.delete(:id); tt.delete("id") }
    end

    raw
  end

  def clean_duplicate_ids
    return unless params[:station]&.[](:timetables_attributes)

    params[:station][:timetables_attributes].each do |_, attrs|
      attrs.delete("id") if attrs["id"].present?
    end
  end

  def prepare_s3_upload
    @s3_direct_post = S3_BUCKET.presigned_post(
      key: "uploads/#{SecureRandom.uuid}/${filename}",
      success_action_status: "201",
      acl: "public-read"
    )
  end
end
