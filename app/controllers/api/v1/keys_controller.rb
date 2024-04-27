class Api::V1::KeysController < ApplicationController
  before_action :set_key, only: %i[ show ]

  def show
    key_json_response(@key)
  end

  def index
    @keys = Key.all
    key_json_response(@keys)
  end

  def create
    @key = Key.new(key_params)

    if @key.save
      key_json_response(@key)
    else
      render :json => {:error => "Key not created"}.to_json, :status => 400
    end
  end

  private
    def set_key
      @key = Key.find(params[:id])
    end

    def key_params
      params.require(:key).permit(:site, :value, :user_id)
    end
end