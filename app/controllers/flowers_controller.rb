class FlowersController < ApplicationController
  before_action :set_flower, only: %i[ show edit update destroy ]
  # before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :require_moderator_access_or_more, only: [ :new, :create, :edit, :update, :destroy ]

  # GET /flowers or /flowers.json
  def index
    @flowers = Flower.all
  end

  def add_to_cart
    flower = Flower.find(params[:id])
    amount = params[:amount].to_i

    if amount.between?(1, flower.stock)
      # Logic to handle adding to the cart can be added here if needed.
      # flash[:notice] = "Successfully added flowers to cart."
      # format.html { redirect_to @flower, notice: "Successfully added flowers to cart." }
      redirect_to root_path,  flash: { notice: "Successfully added flowers to cart.", type: "success" }
    else
      # format.html { redirect_to @flower, notice: "Invalid amount of flowers selected." }
      # flash[:alert] = "Invalid amount of flowers selected."
      redirect_to root_path,  flash: { notice: "Invalid amount of flowers selected.", type: "error" }
    end

  end
  # GET /flowers/1 or /flowers/1.json
  def show
    # flash[:notice] = "Just testing"
  end

  # GET /flowers/new
  def new
    @flower = Flower.new
  end

  # GET /flowers/1/edit
  def edit
  end

  # POST /flowers or /flowers.json
  def create
    @flower = Flower.new(flower_params)

    respond_to do |format|
      if @flower.save
        format.html { redirect_to @flower, notice: "Flower was successfully created." }
        format.json { render :show, status: :created, location: @flower }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @flower.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flowers/1 or /flowers/1.json
  def update
    respond_to do |format|
      if @flower.update(flower_params)
        format.html { redirect_to @flower, flash: { notice: "Flower was successfully updated." } }
        format.json { render :show, status: :ok, location: @flower }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @flower.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flowers/1 or /flowers/1.json
  def destroy
    @flower.destroy!

    respond_to do |format|
      format.html { redirect_to flowers_path, status: :see_other, notice: "Flower was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flower
      @flower = Flower.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def flower_params
      params.require(:flower).permit(:name, :description, :price, :stock, :image)
    end
end
