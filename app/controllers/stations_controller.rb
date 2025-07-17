class StationsController < ApplicationController
  before_action :set_station, only: [:show, :edit, :update, :destroy]
  before_action :set_station_on_id, only: [:articles]

  def index
    @radio_programs = Station.where(video: false, news: false).order(frequency: :asc)
    @video_programs = Station.where(video: true).order(frequency: :asc)
    @news_channels = Station.where(news: true).order(frequency: :asc)
  end

  def show
    @https_src = "https://59dcdb8f833ed.streamlock.net:443/Shoutcast/#{@station.stream_url}.stream/playlist.m3u8"
    @rtmps_src = "rtmps://59dcdb8f833ed.streamlock.net:443/Shoutcast/#{@station.stream_url}.stream"
    session[:article_id] = nil

    if params[:tag]
      redirect_to search_results_path(params[:tag])
      return
    end

    @recommendations = Station.where.not(id: @station.id).where(news: false).last(7)
    time = Time.now
    weekday = time.strftime("%A").downcase

    @timetables = Timetable.where("#{weekday} = ? AND station_id = ? AND (streaming_hour < ? AND end_streaming_hour > ? OR streaming_hour > ?)", true, @station.id, time, time, time).order(streaming_hour: :asc).first(5)
  end

  def new
    @station = Station.new
    21.times { @station.timetables.build }
    @s3_direct_post = S3_BUCKET.presigned_post(
      key: "uploads/#{SecureRandom.uuid}/${filename}",
      success_action_status: "201",
      acl: "public-read"
    )
  end

  def edit
    21.times { @station.timetables.build } if @station.timetables.size < 21
    @s3_direct_post = S3_BUCKET.presigned_post(
      key: "uploads/#{SecureRandom.uuid}/${filename}",
      success_action_status: "201",
      acl: "public-read"
    )
  end

  def create
    if params[:station] && params[:station][:timetables_attributes]
      params[:station][:timetables_attributes].each do |key, attrs|
        attrs.delete("id")
      end
    end

    @station = Station.new(station_params)

    if @station.save
      @station.update(slug: @station.slug)
      redirect_to panel_station_path(@station), notice: "Estación creada correctamente."
    else
      @s3_direct_post = S3_BUCKET.presigned_post(
        key: "uploads/#{SecureRandom.uuid}/${filename}",
        success_action_status: "201",
        acl: "public-read"
      )
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
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "No encontramos lo que estabas buscando"
    redirect_to root_url
  end

  def set_station
    @station = Station.where("slug ILIKE ?", params[:id])
    if @station.empty?
      flash[:alert] = "No encontramos lo que estabas buscando"
      redirect_to root_url
    else
      @station = @station.first
    end
  end

  def station_params
    raw = params.require(:station).permit(
      :name, :frequency, :description,
      :playlist_1, :playlist_2, :playlist_3, :playlist_4,
      :playlist_1_image, :playlist_2_image,
      :playlist_3_image, :playlist_4_image,
      :stream_url, :app_url, :facebook, :twitter,
      :video, :news, :image, :image_preview,
      timetables_attributes: [
        :id, :name, :broadcasters, :description,
        :streaming_hour, :end_streaming_hour,
        :monday, :tuesday, :wednesday, :thursday,
        :friday, :saturday, :sunday,
        :image, :broadcaster_image,
        :_destroy
      ]
    )

    # Hotfix: limpiar IDs duplicados si llegan desde el form
    if raw[:timetables_attributes]
      raw[:timetables_attributes].each do |_, tt|
        tt.delete(:id)
        tt.delete("id")
      end
    end

    raw
  end

  def clean_duplicate_ids
    return unless params[:station].present? && params[:station][:timetables_attributes].present?

    params[:station][:timetables_attributes].each do |key, attrs|
      attrs.delete("id") if attrs["id"].present?
    end
  end
end