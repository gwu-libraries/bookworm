class Api::V1::InvestigationsController < ApplicationController
  before_action :set_investigation, only: %i[ show ]

  def index
    @investigations = Investigation.all
    investigation_json_response(@investigations)
  end

  def show
    investigation_json_response(@investigation)
  end

  def create
    @investigation = Investigation.new(investigation_params)

    if @investigation.save
      investigation_json_response(@investigation)
    else
      render :json => {:error => "Investigation not created"}.to_json, :status => 400
    end
  end

  private

    def set_investigation
      @investigation = Investigation.find(params[:id])
    end

    def investigation_params
      params.require(:investigation).permit(:name, :user_id)
    end
end