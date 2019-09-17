class Carrier < ApplicationRecord
  belongs_to :location
  has_many :loans
  belongs_to :category

  include Filterable

  # scope :starts_with, -> (name) { where("name ilike ?", "%#{name}%")}
  # scope :manufacturer, -> (manufacturer) { where(manufacturer: manufacturer) }
  # scope :model, -> (model) { where(model: model) }
  
  scope :location, -> (location_id) { where location_id: location_id }

  validates :item_id, uniqueness: { message: 'Item ID has already been taken' }
  validates_presence_of [
    :name,
    :item_id,
    :location_id,
    :default_loan_length_days,
    :category_id
  ]

  has_many_attached :photos

  def build_loan(attributes = {})
    loans.create({
      due_date: Date.today + default_loan_length_days.days,
    }.merge(attributes))
  end
end
