class ShippingCsvHooks < Spree::ThemeSupport::HookListener

  insert_after :admin_orders_index_search_buttons do
    %(  <script>
          function submitCSV()
          { 
            var startDate = document.getElementById('search_created_at_after')
            var endDate = document.getElementById('search_created_at_before')

            window.location = "/admin/shippingdocs" + "?start=" + startDate.value + "&end=" + endDate.value
          }
        </script>
        <p><button type="button" onclick="javascript:submitCSV()"><span>CSV</span></button>
    )
  end

end
