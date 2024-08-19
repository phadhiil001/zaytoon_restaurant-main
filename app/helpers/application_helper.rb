module ApplicationHelper
  def breadcrumbs(product)
    content_tag(:nav, aria: { label: 'breadcrumb' }) do
      content_tag(:ol, class: 'breadcrumb') do
        concat(content_tag(:li, link_to('Home', root_path), class: 'breadcrumb-item'))
        concat(content_tag(:li, link_to('Products', products_path), class: 'breadcrumb-item'))
        concat(content_tag(:li, product.category.name, class: 'breadcrumb-item')) if product.category
        concat(content_tag(:li, product.name, class: 'breadcrumb-item active', aria: { current: 'page' }))
      end
    end
  end
end
