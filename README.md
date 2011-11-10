This extension will add a CSV export button to the admin orders page that allows the user to export order information.

To install, add to Gemfile:

	gem 'shipping_csv', :git => 'git://github.com/OshinKaramian/spree-shipping-csv.git', :branch => '0.60.x'

And update your bundle:

	bundle update

If you want to alter the output of the CSV file, define your own methods in 

    /app/helpers/admin/shippingdocs_helper.rb


