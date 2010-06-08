# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ShippingCsvExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/shipping_csv"

  # Please use shipping_csv/config/routes.rb instead for extension routes.

   def self.require_gems(config)
     config.gem "fastercsv"
   end
  
  def activate

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
  end
end
