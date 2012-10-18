class Admin::QualifiersController < Admin::BaseController
  # GET /admin/qualifiers
  # GET /admin/qualifiers.json
  def index
    @qualifiers = Qualifier.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @qualifiers }
    end
  end

  # GET /admin/qualifiers/new
  # GET /admin/qualifiers/new.json
  def new
    @qualifier = Qualifier.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @qualifier }
    end
  end

  # GET /admin/qualifiers/1/edit
  def edit
    @qualifier = Qualifier.find(params[:id])
  end

  # POST /admin/qualifiers
  # POST /admin/qualifiers.json
  def create
    @qualifier = Qualifier.new(qualifier_params)

    respond_to do |format|
      if @qualifier.save
        format.html { redirect_to admin_qualifiers_path, notice: 'Qualifier was successfully created.' }
        format.json { render json: @qualifier, status: :created, location: @qualifier }
      else
        format.html { render action: "new" }
        format.json { render json: @qualifier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/qualifiers/1
  # PATCH/PUT /admin/qualifiers/1.json
  def update
    @qualifier = Qualifier.find(params[:id])

    respond_to do |format|
      if @qualifier.update_attributes(qualifier_params)
        format.html { redirect_to admin_qualifiers_path, notice: 'Qualifier was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @qualifier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/qualifiers/1
  # DELETE /admin/qualifiers/1.json
  def destroy
    @qualifier = Qualifier.find(params[:id])
    @qualifier.destroy

    respond_to do |format|
      format.html { redirect_to admin_qualifiers_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def qualifier_params
      params.require(:qualifier).permit(:name, :category)
    end
end
