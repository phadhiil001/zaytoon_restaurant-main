ActiveAdmin.register Province do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :gst, :pst, :hst, :qst

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :gst
      f.input :pst
      f.input :hst
      f.input :qst
    end
    f.actions
  end

end
