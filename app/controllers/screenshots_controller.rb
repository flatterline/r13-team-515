class ScreenshotsController < ApplicationController
  before_filter :prepare_params

  ##
  # Provides the latest screenshots available from
  # two news sources.
  def index
    # Pseudocode --
    # Left source should be a random source as well as the
    # right source. The right source should never be assigned
    # to the same source as the left source.
    #
    # @left_source = Source.random
    # @right_source = Source.random.except(@left_source)

    @left_pub     = Publication.friendly.find(params[:left])
    @left_section = @left_pub.publication_sections.where(name: params[:section]).first
    @left_image   = @left_section.screenshots.where(timestamp: params[:timestamp]).first

    @right_pub     = Publication.friendly.find(params[:right])
    @right_section = @right_pub.publication_sections.where(name: params[:section]).first
    @right_image   = @right_section.screenshots.where(timestamp: params[:timestamp]).first
  end

private

  def prepare_params
    params[:timestamp] ||= Screenshot.first.timestamp
    params[:section]   ||= :home
    params[:left]      ||= 'the-new-york-times'
    params[:right]     ||= 'fox-news'
  end
end
