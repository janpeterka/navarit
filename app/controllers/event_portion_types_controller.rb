class EventPortionTypesController < ApplicationController
  before_action :set_event_portion_type, only: %i[show edit update destroy]
  before_action :set_event

  def index
    @event_portion_types = @event.event_portion_types
    @unused_portion_types = current_user.portion_types - @event_portion_types.map(&:portion_type)
  end

  def show; end

  def new
    @event_portion_type = EventPortionType.new(event: @event, portion_type: PortionType.new)
  end

  # GET /event_portion_types/1/edit
  def edit; end

  def create # rubocop:disable Metrics/AbcSize
    authorize! :update, @event

    @portion_type = PortionType.find_by(id: params[:portion_type_id])

    if @portion_type.nil?
      @portion_type = current_user.portion_types.create!(name: portion_type_params[:name],
                                                         size: portion_type_params[:size])
    end

    if portion_count_difference > @event.portion_type_remaining_attendee_count
      flash[:error] = "nemůžeš přidat víc lidí než je volných míst"
      redirect_back_or_to @event
      return
    end

    @event_portion_type = @event.event_portion_types.new(event_portion_type_params.merge(portion_type: @portion_type))

    if @event_portion_type.save
      redirect_back_or_to @event.event_portion_types, notice: "počet lidí pro #{@portion_type.name} byl změněn.",
                                                      status: :see_other
    else
      flash[:error] = "něco se nepovedlo"
      redirect_back_or_to @event.event_portion_types, status: :see_other
      # this will be back with turbo-frame added
      # render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize! :update, @event

    if portion_count_difference > @event.portion_type_remaining_attendee_count
      flash[:error] = "nemůžeš nastavit víc lidí než je volných míst"
      redirect_back_or_to @event_portion_type.event
      return
    end

    if @event_portion_type.update(event_portion_type_params)
      redirect_back_or_to @event_portion_type.event, notice: "počet lidí pro #{@event_portion_type.portion_type.name} byl změněn.",
                                                     status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :update, @event

    @event_portion_type.destroy!
    redirect_to event_portion_types_url, notice: "Event portion type was successfully destroyed.", status: :see_other
  end

  private

    def set_event_portion_type
      @event_portion_type = EventPortionType.where(event_id: params[:event_id],
                                                  portion_type_id: params[:id]).first
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    def event_portion_type_params
      params.fetch(:event_portion_type, {}).permit(:event_id, :portion_type_id, :count)
    end

    def portion_type_params
      params.fetch(:event_portion_type, {}).permit(:name, :size)
    end

    def portion_count_difference
      event_portion_type_params[:count].to_i - @event.portion_type_attendee_count
    end
end
