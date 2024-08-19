class StaticPagesController < ApplicationController
  def show
    @page = Page.find_by(slug: params[:slug])
    if @page
      render template: "pages/show"
    else
      redirect_to root_path, alert: "Page not found"
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "id_value", "title", "updated_at"]
  end

end
