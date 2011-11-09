module Admin::ShippingdocsHelper

    def csv_header_row
        [
            "order_number", 
            "order_date", 
            "order_total", 
            "billing_first_name", 
            "billing_last_name", 
            "billing_address_1", 
            "billing_address_2", 
            "billing_city", 
            "billing_state", 
            "billing_zip",
            "shipping_first_name", 
            "shipping_last_name", 
            "shipping_address_1", 
            "shipping_address_2", 
            "shipping_city", 
            "shipping_state",
            "shipping_zip", 
            "weight", 
            "email", 
            "payment_state", 
            "shipment_state", 
            "special_instructions", 
            "products_ordered" 
        ]
    end

    def csv_order_row(order)
        
        shipmentWeight = 0
        order.line_items.reject{|i|i.variant.weight.nil?}.each do |item|
            shipmentWeight += item.variant.weight
        end

        [
          order.number, 
          order.completed_at, 
          order.total, 
          order.bill_address.firstname, 
          order.bill_address.lastname, 
          order.bill_address.address1, 
          order.bill_address.address2, 
          order.bill_address.city,
          State.find(:first, :conditions => { :id =>order.bill_address.state_id}).abbr, 
          order.bill_address.zipcode,
          order.ship_address.firstname, 
          order.ship_address.lastname, 
          order.ship_address.address1, 
          order.ship_address.address2, 
          order.ship_address.city ,
          State.find(:first, :conditions => { :id => order.ship_address.state_id}).abbr, 
          order.ship_address.zipcode, 
          shipmentWeight, 
          order.email, 
          order.payment_state, 
          order.shipment_state, 
          order.special_instructions, 
          ordered_items(order)
        ]

    end

    def ordered_items(order)
        items = ""
        for item in order.line_items do 
            items << "#{item.variant.sku} #{item.variant.product.name} #{item.variant.options_text} (#{item.quantity})
"             
        end
        items
    end


end
