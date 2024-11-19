class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  validates :username, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :first_name, presence: true, length: { minimum: 3 }
  validates :last_name, presence: true, length: { minimum: 3 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [ :user, :moderator, :admin ]
  after_initialize :set_default_role, :if => :new_record?


  def set_default_role
    self.role ||= :user
    # self.role = :user
  end
end
