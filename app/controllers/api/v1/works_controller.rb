class Api::V1::WorksController < ApplicationController
  before_action :set_work, only: %i[ show update destroy ]

  # GET /works
  def index
    @works = Work.all

    render json: @works
  end

  # GET /works/1
  def show
    render json: @work
  end

  # POST /works
  def create
    @work = Work.new(work_params)

    if @work.save
      work_json_response(@work)
    else
      render status: 400
    end
  end

  # PATCH/PUT /works/1
  def update
    if @work.update(work_params)
      render json: @work
    else
      render json: @work.errors, status: :unprocessable_entity
    end
  end

  # DELETE /works/1
  def destroy
    @work.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def work_params
      params.require(:work).permit(:doi, :title, :investigation_id)
    end
end
