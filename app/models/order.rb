class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province, optional: true
  has_many :order_items, dependent: :destroy
  has_one :order_tax, dependent: :destroy

  validates :status, presence: true, inclusion: { in: ['new', 'paid', 'shipped'] }
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, presence: true

  # attribute :stripe_payment_id, :string

  def self.ransackable_associations(auth_object = nil)
    ["order_items", "order_tax", "user", "province"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "status", "total_price", "updated_at", "user_id", "province_id", "stripe_payment_id"]
  end
end
