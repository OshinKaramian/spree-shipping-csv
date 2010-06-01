require 'fastercsv'

class Admin::ShippingdocsController < Admin::BaseController
  def index
    @dateStart = DateTime.strptime(params[:start], "%m/%d/%Y")
    @dateEnd = DateTime.strptime(params[:end], "%m/%d/%Y")

    @orders = Order.find(:all, :conditions => { :created_at => @dateStart..@dateEnd })

    csv_string = FasterCSV.generate do |csv|
      # header row
      csv << ["id", "billing_first_name", "billing_last_name", "billing_address_1", "billing_address_2", "billing_city", "billing_state", "billing_zip",
        "shipping_first_name", "shipping_last_name", "shipping_address_1", "shipping_address_2", "shipping_city", "shipping_state", "shipping_zip"]
      
      # data rows
      @orders.each do |order|
        @checkout = Checkout.find(:first, :conditions => {:order_id => order.id})

        if @checkout.bill_address_id.nil? || @checkout.ship_address_id.nil?  then
        else
          @billAddress = Address.find(:first, :conditions => {:id => @checkout.bill_address_id})
          @shipAddress = Address.find(:first, :conditions => {:id => @checkout.ship_address_id})

            csv << [order.id, @billAddress.firstname,@billAddress.lastname, @billAddress.address1, @billAddress.address2, @billAddress.city, @billAddress.state_name, @billAddress.zipcode,
              @shipAddress.firstname,@shipAddress.lastname, @shipAddress.address1, @shipAddress.address2, @shipAddress.city, @shipAddress.state_name, @shipAddress.zipcode]
        end

       end
    end

      # send it to the browsah
      send_data csv_string,
            :type => 'text/csv; charset=iso-8859-1; header=present',
            :disposition => "attachment; filename=users.csv"
  end
end

