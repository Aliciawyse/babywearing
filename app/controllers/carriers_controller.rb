# frozen_string_literal: true

class CarriersController < ApplicationController
  before_action :set_carrier, only: [:show, :edit, :update]

  def index
    @carriers = Carrier
                .with_attached_photos
                .includes(:home_location)
                .all
    @locations = Location.all
  end

  def search
    @locations = Location.all
    @carriers = Carrier.where(location_id: params["location_id"])
    render :index
  end

  def show
  end

  def new
    @carrier = Carrier.new
    @locations = Location.all
    @categories = Category.all
  end

  def create
    @carrier = Carrier.new(carrier_params)
    @carrier.save

    if @carrier.errors.any?
      flash[:errors] = @carrier.errors.full_messages
      redirect_to new_carrier_path(@carrier)
    else
      flash[:success] = 'Carrier successfully created'
      redirect_to @carrier
    end
  end

  def edit
    @locations = Location.all
    @categories = Category.all
  end

  def update
    @carrier.update(carrier_params)

    if @carrier.errors.any?
      flash[:errors] = @carrier.errors.full_messages
      redirect_to edit_carrier_path(@carrier)
    else
      flash[:success] = 'Carrier successfully updated'
      redirect_to @carrier
    end
  end

  def destroy
    @carrier = Carrier.find(params[:id])
    @carrier.destroy
    flash[:success] = 'Carrier successfully destroyed'
    redirect_to carriers_path
  end

  private

  def set_carrier
    @carrier = Carrier.find(params[:id])
  end

  def carrier_params
    params.require(:carrier).permit(
      :search,
      :name,
      :item_id,
      :manufacturer,
      :model,
      :color,
      :size,
      :home_location_id,
      :current_location_id,
      :category_id,
      :default_loan_length_days,
      photos: []
    )
  end

  def filter_params
    return {} unless params.key?(:filters)
    params.require(:filters).slice(:starts_with)
  end
end
