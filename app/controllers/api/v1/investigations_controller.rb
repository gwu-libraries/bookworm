class Api::V1::InvestigationsController < ApplicationController
  before_action :set_investigation, only: %i[ show ]

  def show
    render json: @investigation
  end

  def create
    investigation = Investigation.new(investigation_params)

    if investigation.save
      investigation_json_response(investigation)
    else
      render status: 400
    end
  end

  private
    def investigation_params
      params.require(:investigation).permit(:name)
    end

    def set_investigation
      @investigation = Investigation.find(params[:id])
    end
end