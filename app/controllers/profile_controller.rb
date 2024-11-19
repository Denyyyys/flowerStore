class ProfileController < ApplicationController
  before_action :authenticate_user!

  def index
    @flowers = Flower.all
    @orders = Order.all if current_user.role == "admin"
  end

  def create_order
    order_data = params[:order]
    total_cost = 0
    order_items = []

    # Check stock and calculate total cost
    order_data.each do |flower_id, quantity|
      flower = Flower.find(flower_id)
      quantity = quantity.to_i

      if flower.stock >= quantity
        order_items << { flower: flower, quantity: quantity }
        total_cost += flower.price * quantity
      else
        flash[:alert] = "Insufficient stock for #{flower.name}. Only #{flower.stock} left."
        redirect_to profile_path_url and return
      end
    end

    # Check user's savings
    if current_user.savings >= total_cost
      @order = current_user.orders.create(
        total_price: total_cost,
        city: params[:city],
        street: params[:street],
        post_index: params[:post_index],
        house_number: params[:house_number],
        apartment_number: params[:apartment_number]
      )

      # Create order items and update stock
      order_items.each do |item|
        @order.order_items.create(flower: item[:flower], quantity: item[:quantity])
        item[:flower].update(stock: item[:flower].stock - item[:quantity])
      end

      # Deduct from user's savings
      current_user.update(savings: current_user.savings - total_cost)

      # Set a success flash message for client-side detection
      flash[:notice] = "Order successfully placed!"
      redirect_to order_success_path_url
    else
      flash[:alert] = "Insufficient savings to place this order."
      redirect_to profile_path_url
    end
  end
  def add_savings

  end

  def order_success

  end

  def update_savings
    amount = params[:savings].to_f
    if amount.positive?
      current_user.savings += amount
      if current_user.save
        flash[:notice] = "Savings successfully updated!"
        redirect_to profile_path_url
      else
        flash[:alert] = "Failed to update savings. Please try again."
        render :add_savings
      end
    else
      flash[:alert] = "Please enter a valid positive number."
      render :add_savings
    end
  end

  def authenticate_user!
    unless user_signed_in?
      redirect_to new_user_session_path,  flash: { notice: "You need to log in before proceeding.", type: "error" }
    end
  end
end

