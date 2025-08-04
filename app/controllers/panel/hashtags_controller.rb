class Panel::HashtagsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_news_chief

  autocomplete :hashtag, :name, full: true

  def index
    @hashtags = Hashtag.order(selected: :desc, updated_at: :desc, created_at: :desc).paginate(page: params[:page], per_page: 200)
  end

  def selecting_hashtags
    @hashtags = Hashtag.where(selected: true).order(updated_at: :desc).last(4)
  end

  def switch_hashtag
    hashtag = Hashtag.find(params[:id])

    if hashtag.selected
      hashtag.update(selected: false)
    else
      if Hashtag.where(selected: true).count > 3
        oldest_hashtag = Hashtag.where(selected: true).order(selected_on: :desc).last
        oldest_hashtag&.update(selected: false)
      end

      hashtag.update(selected: true, selected_on: Time.current)
    end

    render json: { hashtag: hashtag }, status: :ok
  end

  def set_selected
    Hashtag.update_all(selected: false)

    %i[h_1 h_2 h_3 h_4].each do |key|
      name = params[:panel][key]
      hashtag = Hashtag.find_by(name: name)
      if hashtag
        hashtag.update(selected: true, selected_on: Time.current)
      else
        Rails.logger.warn "Hashtag no encontrado: #{name}"
      end
    end

    redirect_to panel_hashtags_path
  end
end
