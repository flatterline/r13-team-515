class Screenshot < ActiveRecord::Base
  image_accessor :image

## Associations
  belongs_to :publication_section

## Scopes
  default_scope { order('timestamp DESC') }
end
