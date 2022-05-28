class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :accessory

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :dates_valid?
  validate :unique_dates?

  before_create :set_total

  def dates_valid?
    return unless start_date.present? && end_date.present?
    if start_date < Time.current.beginning_of_day
      return errors.add(:start_date, 'must be in the future')
    end
    if start_date > end_date
      return errors.add(:end_date, 'must be after start date')
    end
  end

  def unique_dates?
    if accessory
         .reservations
         .where('NOT (start_date > ? OR end_date < ?)', end_date, start_date)
         .any?
      return errors.add(:start_date, 'Already taken in those dates')
    end
  end

  def set_total
    total_price = accessory.price * (end_date - start_date).to_i
  end
end
