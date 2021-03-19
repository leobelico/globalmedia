class Api::AuthenticatedController < Api::BaseController
  private
    def check_auth
      unless user_signed_in?
        render json: { error: 'Not Authorized' }, status: 401 unless @current_user
      end
    end
end
