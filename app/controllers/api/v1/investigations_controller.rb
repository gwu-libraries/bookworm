# frozen_string_literal: true

module Api
  module V1
    class InvestigationsController < ApplicationController
      before_action :set_investigation, only: %i[show]
      before_action :set_investigations, only: %i[index]

      def index
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
          render json: { error: 'Investigation not created' }.to_json, status: 400
        end
      end

      def work_list
        works = Investigation.find_by(id: params[:investigation_id]).works

        work_json_response(works)
      end

      private

      def set_investigation
        @investigation = Investigation.find(params[:id])
      end

      def set_investigations
        @investigations = Investigation.all
      end

      def investigation_params
        params.require(:investigation).permit(:name, :user_id)
      end
    end
  end
end
