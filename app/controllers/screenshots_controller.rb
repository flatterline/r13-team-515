class ScreenshotsController < ApplicationController

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

  end

end
