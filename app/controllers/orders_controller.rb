class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def update_status
    @order = Order.find(params[:id])
    if @order.update(order_status: params[:order_status])
      flash[:notice] = "Order status updated successfully."
      redirect_to profile_path_url,  flash: { notice: "Order status updated successfully.", type: "success" }
    else
      flash[:notice] = "Failed to update order status."
      flash[:type] = "error"
      redirect_to profile_path_url, flash: { notice: "Failed to update order status.", type: "error" }
    end
  end

  def update_multiple_statuses
    params[:orders].each do |order_id, order_params|
      order = Order.find(order_id)
      order.update(order_status: order_params[:order_status])
    end

    flash[:notice] = "Order statuses updated successfully."
    redirect_to profile_path_url, flash: { notice: "Order statuses updated successfully.", type: "success" }
  rescue StandardError => e
    flash[:notice] = "Failed to update some order statuses. Error: #{e.message}"
    flash[:type] = "error"
    redirect_to profile_path_url, flash: { notice: "Failed to update some order statuses.", type: "error" }
  end
end
