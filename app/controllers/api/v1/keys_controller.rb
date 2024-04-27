class Api::V1::KeysController < ApplicationController
  before_action :set_key, only: %i[ show ]

  def show
    key_json_response(@key)
  end

  private
    def set_key
      @key = Key.find(params[:id])
    end

    def key_params
      params.require(:key).permit(:site, :value, :user_id)
    end
end