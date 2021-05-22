class RecordsController < ApplicationController
  before_action :must_sign_in

  def index
    render_resources Record.page(params[:page]).per(params[:size])
  end

  def show
    render_resources Record.find(params[:id])
  end

  def create
    render_resource Record.create create_params
  end

  def destroy
    record = Record.find params[:id]
    head record.destroy ? :ok : :bad_request
  end

  def render_resources(resources)
    render json: {resources: resources}
  end

  private

  def create_params
    params.permit(:amount, :category, :notes)
  end
end
