class PublicationSection < ActiveRecord::Base
## Association
  belongs_to :publication

## Validations
  validates :name, :url, presence: true
end
