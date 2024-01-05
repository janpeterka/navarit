class EventPortionTypesController < ApplicationController
  before_action :set_event_portion_type, only: %i[show edit update destroy]
  before_action :set_event

  # GET /event_portion_types
  def index
    @event_portion_types = @event.event_portion_types
    @unused_portion_types = current_user.portion_types - @event_portion_types.map(&:portion_type)
  end

  # GET /event_portion_types/1
  def show; end

  # GET /event_portion_types/new
  def new
    @event_portion_type = EventPortionType.new(event: @event, portion_type: PortionType.new)
  end

  # GET /event_portion_types/1/edit
  def edit; end

  # POST /event_portion_types
  def create # rubocop:disable Metrics/AbcSize
    @portion_type = PortionType.find_by(id: params[:portion_type_id])
    if @portion_type.nil?
      @portion_type = current_user.portion_types.create!(name: portion_type_params[:name],
                                                         size: portion_type_params[:size])
    end

    @event_portion_type = @event.event_portion_types.new(event_portion_type_params.merge(portion_type: @portion_type))

    if @event_portion_type.save
      redirect_back_or_to @event.event_portion_types, notice: "počet lidí pro #{@portion_type.name} byl změněn.",
                                                      status: :see_other
    else
      flash[:error] = 'něco se nepovedlo'
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /event_portion_types/1
  def update
    if @event_portion_type.update(event_portion_type_params)
      redirect_back_or_to  @event_portion_type.event, notice: "počet lidí pro #{@event_portion_type.portion_type.name} byl změněn.",
                                                      status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /event_portion_types/1
  def destroy
    @event_portion_type.destroy!
    redirect_to event_portion_types_url, notice: 'Event portion type was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event_portion_type
    @event_portion_type = EventPortionType.where(event_id: params[:event_id],
                                                 portion_type_id: params[:id]).first
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  # Only allow a list of trusted parameters through.
  def event_portion_type_params
    params.fetch(:event_portion_type, {}).permit(:event_id, :portion_type_id, :count)
  end

  def portion_type_params
    params.fetch(:event_portion_type, {}).permit(:name, :size)
  end
end
