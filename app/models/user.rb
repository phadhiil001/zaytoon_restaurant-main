class User < ApplicationRecord
  belongs_to :province
  has_many :orders, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :province_id, presence: true
  validates :name, presence: true
  validates :address, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "province_id", "remember_created_at", "updated_at", "name", "address"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders", "province"]
  end
end
