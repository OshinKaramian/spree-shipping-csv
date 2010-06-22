require 'fastercsv'

class Admin::ShippingdocsController < Admin::BaseController
  def index
    if params[:start] == "" then
      @dateStart = DateTime.strptime('1/1/1980', "%m/%d/%Y")
    else
      @dateStart = DateTime.strptime(params[:start], "%m/%d/%Y")
    end

    if params[:end] == "" then
      @dateEnd = DateTime.strptime('1/1/3000', "%m/%d/%Y")
    else
      @dateEnd = DateTime.strptime(params[:end], "%m/%d/%Y")
    end
    
    @orders = Order.find(:all, :conditions => { :created_at => @dateStart..@dateEnd })

    csv_string = FasterCSV.generate do |csv|
      # header row
      csv << ["id", "billing_first_name", "billing_last_name", "billing_address_1", "billing_address_2", "billing_city", "billing_state", "billing_zip",
        "shipping_first_name", "shipping_last_name", "shipping_address_1", "shipping_address_2", "shipping_city", "shipping_state",
        "shipping_zip", "weight", "email"]
      
      # data rows
      @orders.each do |order|
        @checkout = Checkout.find(:first, :conditions => {:order_id => order.id})

        if order.state != 'new' then
        else
          @billAddress = Address.find(:first, :conditions => {:id => @checkout.bill_address_id})
          @shipAddress = Address.find(:first, :conditions => {:id => @checkout.ship_address_id})
          @shipmentWeight = 0
          order.line_items.each do |item|
            if item.variant.weight.nil? then
            else
              @shipmentWeight += item.variant.weight
            end
          end
            csv << [order.id, @billAddress.firstname,@billAddress.lastname, @billAddress.address1, @billAddress.address2, @billAddress.city,
              State.find(:first, :conditions => { :id =>@billAddress.state_id}).abbr, @billAddress.zipcode,
              @shipAddress.firstname,@shipAddress.lastname, @shipAddress.address1, @shipAddress.address2,  @shipAddress.city ,
              State.find(:first, :conditions => { :id => @shipAddress.state_id}).abbr, @shipAddress.zipcode, @shipmentWeight, @checkout.email]
        end

       end
    end

      # send it to the browsah
      send_data csv_string,
            :type => 'text/csv; charset=iso-8859-1; header=present',
            :disposition => "attachment; filename=users.csv"
  end
end

