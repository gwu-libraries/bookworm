class Api::V1::WorksController < ApplicationController
  before_action :set_work, only: %i[ show update destroy ]
  before_action :set_works, only: %i[ index ]

  def index
    work_json_response(@works)
  end

  def show
    work_json_response(@work)
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      work_json_response(@work)
    else
      render :json => {:error => "Work not created"}.to_json, :status => 400    
    end
  end

  def update
    if @work.update(work_params)
      work_json_response(@work)
    else
      render json: @work.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @work.destroy!
  end

  private
    def set_work
      @work = Work.find(params[:id])
    end

    def set_works
      @works = Work.all
    end

    def work_params
      params.require(:work).permit(:doi, :title, :investigation_id)
    end
end
