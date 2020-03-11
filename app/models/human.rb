class Human < ApplicationRecord
    has_secure_password
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
    validates :weight, numericality: true
end
