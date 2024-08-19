ActiveAdmin.register Page do
  permit_params :title, :content, :slug

  form do |f|
    f.semantic_errors *f.object.errors.full_messages

    f.inputs "Page Details" do
      f.input :title
      f.input :content, as: :text
      f.input :slug, input_html: { readonly: true }
    end

    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :slug
    actions
  end

  show do
    attributes_table do
      row :title
      row :content
      row :slug
      row :created_at
      row :updated_at
    end
  end
end
