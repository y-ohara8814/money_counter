class Group < ApplicationRecord
    has_many :group_users, foreign_key:"group_id",dependent: :destroy
    has_many :users, through: :group_users
    has_many :plans, foreign_key:"group_id", dependent: :destroy
    accepts_nested_attributes_for :group_users, allow_destroy: true

    validates :name, presence: {message: "グループ名は必須です"}, length: {maximum: 30}

    validates :user_ids, presence: {message: "所属ユーザーは自分を含め１名以上選択してください"}
end
