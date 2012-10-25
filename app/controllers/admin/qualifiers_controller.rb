class Admin::QualifiersController < Admin::BaseController
  respond_to :html

  def index
    @qualifiers = Qualifier.all

    respond_with @qualifiers
  end

  def new
    @qualifier = Qualifier.new

    respond_with @qualifier
  end

  def edit
    @qualifier = Qualifier.find(params[:id])
  end

  def create
    @qualifier = Qualifier.new(qualifier_params)

    respond_with(@qualifier) do |format|
      if @qualifier.save
        format.html { redirect_to admin_qualifiers_path, notice: 'Qualifier was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @qualifier = Qualifier.find(params[:id])

    respond_with(@qualifier) do |format|
      if @qualifier.update_attributes(qualifier_params)
        format.html { redirect_to admin_qualifiers_path, notice: 'Qualifier was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def order
    qualifier_ids = params[:qualifier]

    Qualifier.update_positions(qualifier_ids)
    head :status => :ok
  end

  def destroy
    @qualifier = Qualifier.find(params[:id])
    @qualifier.destroy

    respond_with(@qualifier) do |format|
      format.html { redirect_to admin_qualifiers_url }
    end
  end

  private

    def qualifier_params
      params.require(:qualifier).permit(:name, :category)
    end
end
