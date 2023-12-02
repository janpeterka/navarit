class EventPortionTypesController < ApplicationController
  before_action :set_event_portion_type, only: %i[show edit update destroy]
  before_action :set_event

  # GET /event_portion_types
  def index
    @event_portion_types = @event.event_portion_types
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
  def create
    @event_portion_type = EventPortionType.new(event_portion_type_params)

    if @event_portion_type.save
      redirect_to @event_portion_type, notice: 'Event portion type was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /event_portion_types/1
  def update
    if @event_portion_type.update(event_portion_type_params)
      redirect_to @event_portion_type, notice: 'Event portion type was successfully updated.', status: :see_other
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
    @event_portion_type = EventPortionType.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  # Only allow a list of trusted parameters through.
  def event_portion_type_params
    params.fetch(:event_portion_type, {}).permit(:event_id, :portion_type_id, :count)
  end
end
