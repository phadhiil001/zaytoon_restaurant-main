ActiveAdmin.register Product do
  permit_params :name, :description, :price, :category_id, images: [], options: []

  filter :name
  filter :category
  filter :price
  filter :created_at

  form do |f|
    f.semantic_errors *f.object.errors

    f.inputs "Product Details" do
      f.input :name
      f.input :description
      f.input :price
      f.input :category
      f.input :images, as: :file, input_html: { multiple: true }
      f.input :options, as: :text, input_html: { value: f.object.options.join(", ") }, hint: "Separate options with commas"
    end

    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :category
      row :created_at
      row :updated_at
      row "Images" do |product|
        ul do
          product.images.each do |image|
            li do
              image_tag url_for(image), size: "100x100"
            end
          end
        end
      end
      row :options do |product|
        product.options.join(", ")
      end
    end
  end

  controller do
    def update
      if params[:product][:options].is_a?(String)
        params[:product][:options] = params[:product][:options].split(",").map(&:strip)
      end
      super
    end
  end
end
