class Api::V1::KeysController < ApplicationController
  before_action :set_key, only: %i[ show destroy ]
  before_action :set_keys, only: %i[ index ]

  def show
    key_json_response(@key)
  end

  def index
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

  def destroy
    @key.destroy!
  end

  private
    def set_key
      @key = Key.find(params[:id])
    end

    def set_keys
      @keys = Key.all
    end

    def key_params
      params.require(:key).permit(:site, :value, :user_id)
    end
end