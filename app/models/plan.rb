class Plan < ApplicationRecord
    belongs_to :group, optional: true
    has_many :usages, foreign_key: "plan_id"

    validates :money_amount, presence: true
    validates :year, presence: true
    validates :month, presence: true
    validates :month, presence: true, uniqueness: {scope: [:year, :group_id], message: "この月のプランは作成済みです"}, on: :create
    validates :group_id, presence: true
    validates :choice1, presence: true
    validates :choice2, presence: true
    validates :choice3, presence: true
    validates :group_id, presence: true

end
