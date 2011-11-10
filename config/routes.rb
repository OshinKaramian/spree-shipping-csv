Rails.application.routes.draw do
  match 'admin/shippingdocs', :to => 'admin/shippingdocs#index'
end
