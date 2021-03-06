class CostsController < ApplicationController
  before_action :set_cost, only: %i[show edit destroy]

  # GET /costs or /costs.json
  def index
    @category = Category.find(params[:category_id])
    @costs = Cost.includes(:category).where(category_id: @category.id).order(created_at: :desc)
  end

  # GET /costs/1 or /costs/1.json
  def show
    @category = Category.find(params[:category_id])
    @cost = Cost.find(params[:id])
  end

  # GET /costs/new
  def new
    @cost = Cost.new
    @category = Category.find(params[:category_id])
  end

  # GET /costs/1/edit
  def edit; end

  # POST /costs or /costs.json
  def create
    @cost = Cost.new(cost_params)
    @cost.user_id = current_user.id
    @cost.category_id = params[:category_id]

    respond_to do |format|
      if @cost.save
        format.html { redirect_to category_costs_path(params[:category_id]), notice: 'Cost was successfully created.' }
        format.json { render :show, status: :created, location: @cost }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /costs/1 or /costs/1.json
  def update
    @cost = Cost.find(params[:id])

    respond_to do |format|
      if @cost.update(cost_params)
        format.html { redirect_to category_costs_path(params[:category_id]), notice: 'Cost was successfully updated.' }
        format.json { render :show, status: :ok, location: @cost }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cost.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_cost
    @cost = Cost.find(params[:id])
  end

  # DELETE /costs/1 or /costs/1.json
  def destroy
    @cost = Cost.find(params[:id])
    @cost.destroy

    respond_to do |format|
      format.html { redirect_to category_costs_path(params[:category_id]), notice: 'Cost was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cost
    @cost = Cost.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cost_params
    params.require(:cost).permit(:name, :amount, :user_id, :category_ids)
  end
end
