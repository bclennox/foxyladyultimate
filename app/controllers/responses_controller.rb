class ResponsesController < ApplicationController
  def create
    response = Response.new(params[:response])
  end
end
