class Plan < ApplicationRecord
    belongs_to :group, optional: true
    has_many :usages, foreign_key: "plan_id"

    validates :money_amount, presence: true
    validates :year, presence: true
    validates :month, presence: true
    validates :group_id, presence: true

    attr_accessor :edit_flg

end
