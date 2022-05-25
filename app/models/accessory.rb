class Accessory < ApplicationRecord
  belongs_to :user
  validates :name, :price, :address, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
