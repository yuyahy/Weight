class Weightpost < ApplicationRecord
  belongs_to :human
  validates :human_id, presence: true
  validates :weight, numericality: true
end
