class Publication < ActiveRecord::Base
## Associations
  has_many :publication_sections, dependent: :destroy

## Validations
  validates :name, presence: true
end
