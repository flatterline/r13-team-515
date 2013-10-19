class Publication < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

## Associations
  has_many :publication_sections, dependent: :destroy

## Validations
  validates :name, presence: true
end
