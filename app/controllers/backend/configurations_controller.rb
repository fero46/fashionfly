class Backend::ConfigurationsController < Backend::BackendController
  
  before_action :find_configuration, only: [:show, :edit, :update, :destroy]

  def index
    @configurations = ::Configuration.all
  end

  def show
  end

  def new
    @configuration = ::Configuration.new
  end

  def create
    @configuration = ::Configuration.new(configuration_attributes)
    if @configuration.save
      flash[:notice] = 'Speichern Erfolgreich'
      redirect_to backend_configuration_path(@configuration)
    else
      flash.now[:error] = 'Konnte nicht Speichern'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @configuration.update(configuration_attributes)
      flash[:notice] = 'Änderungen Erfolgreich'
      redirect_to backend_configuration_path(@configuration)
    else
      flash.now[:error] = 'Konnte nicht Speichern'
      render 'edit'
    end
  end

  def destroy
    @configuration.destroy
    redirect_to backend_configurations_path
  end

protected
  
  def find_configuration
    @configuration = ::Configuration.find(params[:id])
  end


  def configuration_attributes
    params.require(:configuration).permit(:key, :value)
  end
end