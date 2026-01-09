class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #アソシエーション
  has_many   :prototypes
  has_many   :comments, dependent: :destroy

  ##バリデーション
  validates :name,        presence: true, uniqueness: true
  validates :profile,     presence: true
  validates :occupation,  presence: true
  validates :position,    presence: true
  
end
