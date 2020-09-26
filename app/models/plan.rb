class Plan < ApplicationRecord
    belongs_to :group, optional: true
    has_many :usages, foreign_key: "plan_id"

    validates :money_amount, presence: true
    validates :year, presence: true
    validates :month, presence: true, uniqueness: {scope: [:year, :group_id], message: "この月のプランは作成済みです"}, unless: :edit_flg_check?

    attr_accessor :edit_flg
    def edit_flg_check?
        edit_flg == true
    end
    validates :group_id, presence: true
    validates :choice1, presence: true
    validates :choice2, presence: true
    validates :choice3, presence: true
    validates :group_id, presence: true

end
