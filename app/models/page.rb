class Page < ApplicationRecord
  validates :title, :content, :slug, presence: true
  validates :slug, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "id_value", "slug", "title", "updated_at"]
  end
end
