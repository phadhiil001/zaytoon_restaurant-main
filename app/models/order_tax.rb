class OrderTax < ApplicationRecord
  belongs_to :order

  validates :gst, :pst, :hst, :qst, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
  validates :order_id, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst", "hst", "id", "id_value", "order_id", "pst", "qst", "updated_at"]
  end

  def total_tax
    gst + pst + hst + qst
  end
end
