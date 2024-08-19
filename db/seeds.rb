# # This file should ensure the existence of records required to run the application in every environment (production,
# # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Example:
# #
# #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
# #     MovieGenre.find_or_create_by!(name: genre_name)
# #   end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?


Province.create([
  { name: 'Alberta', gst: 0.05, pst: 0.00, hst: 0.00, qst: 0.00 },
  { name: 'British Columbia', gst: 0.05, pst: 0.07, hst: 0.00, qst: 0.00 },
  { name: 'Manitoba', gst: 0.05, pst: 0.08, hst: 0.00, qst: 0.00 },
  { name: 'New Brunswick', gst: 0.00, pst: 0.00, hst: 0.15, qst: 0.00 },
  { name: 'Newfoundland and Labrador', gst: 0.00, pst: 0.00, hst: 0.15, qst: 0.00 },
  { name: 'Nova Scotia', gst: 0.00, pst: 0.00, hst: 0.15, qst: 0.00 },
  { name: 'Ontario', gst: 0.00, pst: 0.00, hst: 0.13, qst: 0.00 },
  { name: 'Prince Edward Island', gst: 0.00, pst: 0.00, hst: 0.15, qst: 0.00 },
  { name: 'Quebec', gst: 0.05, pst: 0.00, hst: 0.00, qst: 0.09975 },
  { name: 'Saskatchewan', gst: 0.05, pst: 0.06, hst: 0.00, qst: 0.00 }
])


Page.create(title: "About Us", content: "This is the About Us page content.", slug: "about")
Page.create(title: "Contact Us", content: "This is the Contact Us page content.", slug: "contact")


# Suppress warnings
$VERBOSE = nil

require 'json'
require 'open-uri'
require 'uri'

# Load JSON data
file_path = Rails.root.join('db', 'menu.json')
json = JSON.parse(File.read(file_path))

# Function to create products
def create_product(product_data, category)
  if product_data["name"].present? && product_data["price"].present? && product_data["price"].is_a?(Numeric)
    product = Product.find_or_create_by(
      name: product_data["name"],
      description: product_data["description"] || "No description available",
      price: product_data["price"],
      category: category,
      on_sale: [true, false].sample, # Randomly mark some products as on sale
      created_at: Time.now - rand(1..3).days, # Randomly set created_at within the last 10 days
      updated_at: Time.now - rand(1..3).days   # Randomly set updated_at within the last 5 days
    )
    product.options = product_data["options"] if product_data["options"]
    product.served_with = product_data["served_with"] if product_data["served_with"]
    product.pieces = product_data["pieces"] if product_data["pieces"]
    product.extra = product_data["extra"] if product_data["extra"]
    product.save!

    # Check for and attach images
    if product_data["image_url"].present?
      begin
        downloaded_image = URI.open(product_data["image_url"])
        product.images.attach(io: downloaded_image, filename: File.basename(URI.parse(product_data["image_url"]).path))
        puts "Image successfully attached to product: #{product.name}"
      rescue OpenURI::HTTPError, URI::InvalidURIError, Errno::ENOENT => e
        puts "Error downloading image for #{product_data['name']}: #{e.message}"
      end
    else
      puts "No image URL provided for product: #{product.name}"
    end
  else
    puts "Skipping product #{product_data['name']} due to missing or invalid price"
  end
end

# Create categories and products
json.each do |category_name, products|
  category = Category.find_or_create_by(name: category_name.titleize)
  products.each do |product_data|
    if product_data["items"]
      product_data["items"].each do |nested_product|
        create_product(nested_product, category)
      end
    else
      create_product(product_data, category)
    end
  end
end
