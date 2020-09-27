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
  validates :password, presence: true,if: -> { new_record? || changes["password"]}

  def self.guest
    find_or_create_by!(name: 'ゲストユーザー',email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
