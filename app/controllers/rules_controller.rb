class RulesController < ApplicationController
  before_action :set_rule, only: [:show, :edit, :update, :destroy]
  before_filter :require_authentication, only: [:new, :create]
  before_filter :require_authorization, only: [:edit, :destroy]
  before_filter :require_params, only: [:create]

  # GET /rules
  # GET /rules.json
  def index

    @selected_capabilities = params[:capabilities] || []

    @rules = Rule.where("code LIKE ?", "%#{params[:q]}%")

    @selected_capabilities.each do |capability|
      @rules = @rules.where("capabilities LIKE ?", "%#{capability}%")
    end

    @rules = @rules.page(params[:page])
  end

  # GET /rules/1
  # GET /rules/1.json
  def show
  end

  # GET /rules/new
  def new
    @rule = Rule.new
  end

  # GET /rules/1/edit
  def edit
  end

  # POST /rules
  # POST /rules.json
  def create
    @rule = current_user.rules.new(Rule.create_params(rule_params))
    
    respond_to do |format|
      if @rule.save
        format.html { redirect_to @rule, notice: 'Rule was successfully created.' }
        format.json { render :show, status: :created, location: @rule }
      else
        format.html { render :new }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rules/1
  # PATCH/PUT /rules/1.json
  def update
    respond_to do |format|
      if @rule.update(rule_params)
        format.html { redirect_to @rule, notice: 'Rule was successfully updated.' }
        format.json { render :show, status: :ok, location: @rule }
      else
        format.html { render :edit }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rules/1
  # DELETE /rules/1.json
  def destroy
    @rule.destroy
    respond_to do |format|
      format.html { redirect_to rules_url, notice: 'Rule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rule
    @rule = Rule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rule_params
    params.require(:rule).permit(:rule_type, :name, :description, :summary, :capabilities, :code)
  end

  def require_authorization
    if !current_user.author_of?(params[:id])
      flash[:notice] = "You do not have permission for that action."
      redirect_to :root 
    end
  end
  
  def require_params
    if rule_params[:code].blank? or Rule.create_params(rule_params)[:name].blank?
      flash[:notice] = "Code cannot be blank and must contain a name property, otherwise a name property must be explicitly provided."
      redirect_to :root
    end
  end
end
