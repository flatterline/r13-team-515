class PublicationSection < ActiveRecord::Base
## Association
  belongs_to :publication
  has_many   :screenshots

## Validations
  validates :name, :url, presence: true
end
