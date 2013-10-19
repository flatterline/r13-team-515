class Screenshot < ActiveRecord::Base
  image_accessor :image

  belongs_to :publication_section
end
