ActiveAdmin.register Category do
  permit_params :name, :description, :image

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :description
      row :created_at
      row :updated_at
      row :image do |category|
        if category.image.attached?
          image_tag url_for(category.image)
        else
          content_tag(:span, "No image attached")
        end
      end
    end
    active_admin_comments
  end

  filter :name
  filter :created_at
end
