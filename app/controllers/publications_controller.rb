class PublicationsController < ApplicationController
  respond_to :json

  def index
    respond_with(@publications = Publication.all)
  end
end
