# frozen_string_literal: true

class ArchivedEventsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])

    authorize! :archive, @event

    @event.archive!

    redirect_back_or_to @event, notice: "akce byla archivována"
  end

  def destroy
    @event = Event.find(params[:id])

    authorize! :unarchive, @event

    @event.restore!

    redirect_back_or_to @event, notice: "akce byla obnovena"
  end
end
