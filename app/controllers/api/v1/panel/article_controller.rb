class Api::V1::Panel::ArticleController < Api::AuthenticatedController

  before_action :check_auth

  def index
    result = Article.order(created_at: "DESC")
    pagination(0, 10, result)
  end
  def create
    json_response(params)
  end
  def show
    @id = params[:id]
    @result = Article.find(@id)
    json_response(@result)
  end
  def update
    @articles = Article.order(created_at: "DESC")
    paginate json: @articles, adapter: :json, per_page: 5
  end
  def destroy
    @id = params[:id]
    @result = Article.find(@id)
    if @result
      Article.destroy(@id);
    end
    json_response(@result)
  end
end
