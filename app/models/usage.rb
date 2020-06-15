class Usage < ApplicationRecord
    belongs_to :group, optional: true
    belongs_to :user

    validates :spending_money, presence: true
    validates :date, presence: true
    validates :purpose, presence: true
end
