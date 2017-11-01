class Panel::ControlsController < ApplicationController
	before_action :authenticate_user!
	# load_and_authorize_resource
	before_action :check_remote_controls_permission
	before_action :set_control, only: [:show, :edit, :update, :destroy]
	def index
		@controls = Control.where(contract_state: "Por Realizar").order(init_date: :asc).paginate(page: params[:page], per_page: 20)
	end
	def done
		@controls = Control.where(contract_state: "Realizado").paginate(page: params[:page], per_page: 20)
	end

	def new
		@control = Control.new	
	end
	def download_controls
		@controls = Control.all

		respond_to do |format|
    		format.xls 
  		end
	end
	def create
		@control = Control.new(control_params)
		if @control.save
			redirect_to panel_controls_path
		else
			render action: "new"
		end
	end

	def edit

	end

	def update
		if @control.update(control_params)
			redirect_to panel_controls_path
		else
			render action: "edit"
		end
	end

	def destroy
		@control.destroy
		redirect_to panel_controls_path
	end

	private
		def control_params
			params.require(:control).permit(:init_date, :end_date, :client_name, :event_name, :event_address, :station_name, :unit_name, :techs, :observations, :contract_number, :contract_state, :agent_name, :datasheet)
		end

		def set_control
			@control = Control.find(params[:id])
		end

end
