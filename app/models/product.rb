class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many_attached :images

  serialize :options, Array, coder: JSON
  serialize :extra, Hash, coder: JSON

  scope :on_sale, -> { where(on_sale: true) }
  scope :new_products, -> { where('created_at >= ?', 3.days.ago) }
  scope :recently_updated, -> { where('updated_at >= ?', 3.days.ago) }

  validates :name, presence: true
  validates :description, length: { maximum: 1000 }, allow_blank: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :category_id, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "extra", "id", "id_value", "name", "options", "pieces", "price", "served_with", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "images_attachments", "images_blobs", "order_items"]
  end

end
