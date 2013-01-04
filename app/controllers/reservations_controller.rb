class ReservationsController < ApplicationController

  def new
    @reservation ||= new_reservation
  end

  def server_selection
    @servers = Server.reservable_by_user(current_user)
  end

  def index
    @users_reservations = current_user.reservations.order('starts_at DESC').limit(100)
  end

  def edit
  end

  def show
  end

  def create
    @reservation = Reservation.new(params[:reservation])
    @reservation.user_id     = current_user.id
    @reservation.date        = Date.today
    if @reservation.save
      if @reservation.now?
        @reservation.update_configuration
        flash[:notice] = "Reservation created for #{@reservation.server_name}. Give the server a minute to (re)boot and <a href='#{@reservation.steam_connect_url}'>click here to join</a> or enter in console: #{@reservation.connect_string}".html_safe
      else
        flash[:notice] = "Reservation created for #{@reservation}"
      end
      redirect_to root_path
    else
      render :new
    end
  end

  def extend
    begin
      reservation.extend!
      flash[:notice] = "Reservation extended by 1 hour to #{I18n.l(reservation.ends_at, :format => :datepicker)}"
    rescue
      flash[:alert] = "Could not extend, conflicting reservation by #{reservation.colliding_reservations.map(&:to_s).join(', ')}"
    ensure
      redirect_to root_path
    end
  end

  def destroy
    if reservation.future?
      flash[:notice] = "Reservation for #{@reservation} cancelled"
      reservation.destroy
    elsif reservation.now?
      if reservation.provisioned?
        reservation.end_reservation
        link = "/uploads/#{reservation.zipfile_name}"
        flash[:notice] = "Reservation removed, restarting server. Get your STV demos and logs <a href='#{link}' target=_blank>here</a>".html_safe
      else
        flash[:notice] = "Reservation cancelled"
        logger.info "A reservation that was supposed to be active, but wasn't provisioned yet, was cancelled"
        reservation.destroy
      end
    end
    redirect_to root_path
  end

  def reservation
    @reservation ||= begin
                       if params[:id]
                         current_user.reservations.find(params[:id].to_i)
                       end
                     end
  end
  helper_method :reservation

  private

  def new_reservation
    Reservation.new(:user_id => current_user.id, :server => server, :starts_at => Time.now, :ends_at => 2.hours.from_now)
  end

  def server
    @server ||= Server.find(params[:server_id].to_i)
  end
  helper_method :server

end
