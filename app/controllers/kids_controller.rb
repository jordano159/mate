class KidsController < ApplicationController
  before_action :set_kid, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_staff!
  helper_method :sort_column, :sort_direction

  # GET /kids
  # GET /kids.json
  def index
    if params[:search]
      @kids = Kid.search(params[:search]).order("created_at DESC").page(params[:page]).per(50)
    else
      @kids = Kid.order(sort_column + " " + sort_direction).page(params[:page]).per(50)
    end

    respond_to do |format|
      format.html
      format.csv { send_data @kids.to_csv, filename: "חניכי המדצופי-#{Date.today}.csv" }
    end
  end



  # GET /kids/1
  # GET /kids/1.json
  def show
  end

  # GET /kids/new
  def new
    @kid = Kid.new
    @groups = Group.all
  end

  # GET /kids/1/edit
  def edit
    @groups = Group.all
  end

  # POST /kids
  # POST /kids.json
  def create
    @kid = Kid.new(kid_params)
    @groups = Group.all

    respond_to do |format|
      if @kid.save
        format.html { redirect_to @kid, notice: 'Kid was successfully created.' }
        format.json { render :show, status: :created, location: @kid }
      else
        format.html { render :new }
        format.json { render json: @kid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kids/1
  # PATCH/PUT /kids/1.json
  def update
    @groups = Group.all
    respond_to do |format|
      if @kid.update(kid_params)
        format.html { redirect_to @kid, notice: 'Kid was successfully updated.' }
        format.json { render :show, status: :ok, location: @kid }
      else
        format.html { render :edit }
        format.json { render json: @kid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kids/1
  # DELETE /kids/1.json
  def destroy
    @kid.destroy
    respond_to do |format|
      format.html { redirect_to kids_url, notice: 'Kid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    Kid.my_import(params[:file])
    redirect_to kids_path, notice: "הייבוא עבר בהצלחה!"
  end

  private

    def sortable_columns
      ["name", "last_name"]
    end

    def sort_column
      sortable_columns.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_kid
      @kid = Kid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kid_params
      params.require(:kid).permit(:name, :group_id)
    end
end
