class Usage < ApplicationRecord
    belongs_to :group, optional: true
    belongs_to :user

    validates :spending_money, presence: {message: "入力必須です"}
    validates :date, presence: {message: "入力必須です"}
    validates :purpose, presence: {message: "入力必須です"}
    validates :plan_id, presence: {message: "入力必須です"}

    attr_accessor :purpose_text
    before_save :check_purpose_text

    private
        def check_purpose_text
            return if purpose != "other"
            if purpose_text.present?
                self.purpose = "その他（#{purpose_text}）"
            else
                self.purpose = "その他（記入なし）"
            end
        end
end
