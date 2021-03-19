class Api::BaseController < ActionController::Base
	include ActionController::Serialization
	include Response
  include ExceptionHandler
  # include ActionController::HttpAuthentication::Token::ControllerMethods
  
  # before_action :authenticate_request 
  # attr_reader :current_user 

  # private 
  #   def authenticate_request 
      
  #     current_user = AuthorizeApiRequest.call(request.headers).result 
  #     render json: { error: 'Not Authorized' }, status: 401 unless current_user 
  #   end
	def pagination(pageIndex, itemsPerPage, query)
		itemsPerPage = itemsPerPage < 1 ? 1 : itemsPerPage
		paginationInfo = paginationInfo(itemsPerPage, query)
		pageIndex = pageIndex < 0 || paginationInfo['totalPages'] <= 0 ? 0 : pageIndex >= paginationInfo['totalPages'] ? paginationInfo['totalPages'] - 1 : pageIndex;
		skip = pageIndex * itemsPerPage
		data = query.offset(skip).limit(itemsPerPage)
		pagination = {
											 'pageIndex' => pageIndex,
											 'data' => data,
											'paginationInfo' => paginationInfo
									 }
		render json: pagination, status: 200
	end

  def paginationInfo(itemsPerPage, query)
		itemsPerPage = itemsPerPage < 0 ? 5 : itemsPerPage
		totalItems = !query.nil? ? query.count : 0
		if totalItems == 0
			{
					'totalItems' => 0,
					'itemsPerPage' => itemsPerPage,
					'totalPages' => 0
			}
		else
			totalPages = totalItems % itemsPerPage == 0 ? totalItems / itemsPerPage : (totalItems / itemsPerPage).to_i + 1
			{
					'totalItems' => totalItems,
					'itemsPerPage' => itemsPerPage,
					'totalPages' => totalPages
			}
		end
	end
end