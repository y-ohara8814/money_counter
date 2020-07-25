class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :group_users, foreign_key:"user_id", dependent: :destroy
  has_many :groups, through: :group_users
  has_many :usages, foreign_key: "user_id"

  validates :name, presence: true
  validates :email, presence: true
  # validates :password, presence: true #この記述があるとグループ新規作成時、Users is invalidというエラーが出る

end
