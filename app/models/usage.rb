class Usage < ApplicationRecord
    belongs_to :group, optional: true
    belongs_to :user

    validates :spending_money, presence: true
    validates :date, presence: true
    validates :purpose, presence: true

    attr_accessor :purpose_text
    before_save :check_purpose_text

    private
        def check_purpose_text
            return if purpose != "other"
            if purpose_text.present?
                purpose = purpose_text
            else
                purpose = "その他（記入なし）"
            end
        end
end
