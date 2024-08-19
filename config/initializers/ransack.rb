# config/initializers/ransack.rb

Rails.application.config.to_prepare do
  ActiveStorage::Attachment.class_eval do
    def self.ransackable_attributes(auth_object = nil)
      %w[id name record_type created_at]
    end

    def self.ransackable_associations(auth_object = nil)
      %w[blob record]
    end
  end

  ActiveStorage::Blob.class_eval do
    def self.ransackable_attributes(auth_object = nil)
      %w[id key filename content_type metadata service_name byte_size checksum created_at]
    end
  end

  Category.class_eval do
    def self.ransackable_attributes(auth_object = nil)
      %w[name description created_at updated_at]
    end
  end

  Product.class_eval do
    def self.ransackable_attributes(auth_object = nil)
      %w[name description price category_id created_at updated_at]
    end

    def self.ransackable_associations(auth_object = nil)
      %w[category]
    end
  end
end
