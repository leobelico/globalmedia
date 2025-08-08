class Panel::HashtagsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_news_chief

  autocomplete :hashtag, :name, full: true

  def index
    # Reducido a 50 por página para mejorar rendimiento
    @hashtags = Hashtag.order(selected: :desc, updated_at: :desc, created_at: :desc)
                       .paginate(page: params[:page], per_page: 50)
  end

  def selecting_hashtags
    # Usar limit y order para que la DB devuelva solo 4 registros (más rápido y menos memoria)
    @hashtags = Hashtag.where(selected: true)
                       .order(updated_at: :desc)
                       .limit(4)
  end

  def switch_hashtag
    hashtag = Hashtag.find(params[:id])

    if hashtag.selected
      hashtag.update(selected: false)
    else
      # Mejor usar .exists? para checar si hay más de 3 seleccionados
      if Hashtag.where(selected: true).limit(4).count > 3
        # Traer el más viejo usando order asc y first (no last que carga todo)
        oldest_hashtag = Hashtag.where(selected: true).order(selected_on: :asc).first
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
