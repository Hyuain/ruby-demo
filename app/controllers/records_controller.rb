class RecordsController < ApplicationController
  before_action :must_sign_in

  def index
    render_resources Record.page(params[:page]).per(params[:size])
  end

  def show
    render_resource Record.find(params[:id])
  end

  def update
    record = Record.find(params[:id])
    record.update create_params
    render_resource record
  end

  def create
    record = Record.create create_params.merge user: current_user
    render_resource record
  end

  def destroy
    record = Record.find params[:id]
    head record.destroy ? :ok : :bad_request
  end

  def render_resources(resources)
    render json: { resources: resources }, status: 200
  end

  private

  def create_params
    params.permit(:amount, :category, :notes)
  end
end
