class Weightpost < ApplicationRecord
  belongs_to :human
  validates :human_id, presence: true
  validates :weight, numericality: true
  
  def can_not_duplicated_date
    if Tweet.exists?(created_at: Time.zone.now.all_day)
      errors.add(:time, '重複しています')
    end
  end
 
end
