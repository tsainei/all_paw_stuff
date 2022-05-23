class Accessory < ApplicationRecord
  belongs_to :user
  validates [:name, :price, :address], presence: true
end
