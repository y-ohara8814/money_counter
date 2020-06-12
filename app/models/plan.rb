class Plan < ApplicationRecord
    belongs_to :group, optional: true

    validates :money_amount, presence: true
    validates :year, presence: true
    validates :month, presence: true
    validates :group_id, presence: true

end
