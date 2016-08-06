Deface::Override.new(:virtual_path => 'spree/admin/orders/_shipment',
  :name => 'add_shipment	',
  :insert_before => "[data-hook='admin_shipment_form']",
  :text => '<br>
  <% url= shipment_label_url(shipment.id) %>
  <% return_url= shipment_return_label_url(shipment.id) %>
  <% if @order.approved? %> 
    <div style="margin-bottom: 11px;">
    <% if url.present? %>
        <%= link_to "create shipment","", :class => "btn btn-primary", :disabled=> true %>
        <%= link_to "Print Label", url, :target=> "_blank", :class => "btn btn-success" %>
        <%= link_to "refund label", admin_goshipments_refund_path(:shipment_id =>shipment.id), :class => "btn btn-danger" %>
        <% if return_url.present? %>
          <%= link_to "Print Return Label", return_url, :target=> "_blank", :class => "btn btn-success" %>
        <% else %>
          <%= link_to "create return label", admin_goshipments_return_parcel_path(:shipment_id =>shipment.id), :class => "btn btn-primary" %>
        <% end %>
      <% else %>
        <%= link_to "create shipment", admin_goshipments_new_parcel_path(:shipment_id =>shipment.id), :class => "btn btn-primary" %>
        <%= link_to "Print Label","", :target=> "_blank", :class => "btn btn-success", :disabled=> true %>
      <% end %>
    </div>
  <% end %>
  ')