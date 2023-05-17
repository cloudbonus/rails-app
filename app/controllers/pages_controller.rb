# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @net_devices = NetworkDevice.none
  end

  def search
    @budget = params[:price].to_f
    @users = params[:users].to_i
    @bandwidth = params[:bandwidth].to_i

    @net_devices = search_devices_in_db
    devices = split_devices_by_type

    if devices.any?(&:empty?)
      render_page(true)
    else
      @searched_devices, @price = get_devices_and_price(devices)
      render_page(false)
    end
  end

  private

  def search_devices_in_db
    NetworkDevice.where('bandwidth >= ?', @bandwidth)
                 .where('price <= ?', @budget)
                 .order(ports: :desc)
  end

  def split_devices_by_type
    devices = Array.new(3) { [] }
    @net_devices.each do |device|
      case device[:d_type]
      when 'router'
        devices[0] << device
      when 'switch'
        devices[1] << device
      else
        devices[2] << device
      end
    end
    devices
  end

  def get_devices_and_price(devices)
    result_devices_and_total_price = devices.map do |devices_set|
      result_devices = []
      users_tmp = @users
      total_price = 0

      while users_tmp.positive? && total_price <= @budget
        max_n, max_users = get_with_max_users(devices_set, users_tmp)
        result_devices << devices_set[max_n]
        users_tmp -= max_users
        total_price += devices_set[max_n][:price]
      end

      [result_devices, total_price]
    end

    result_devices_and_total_price.transpose.map { |arr| arr.reduce(:+) }
  end

  def get_with_max_users(devices, users)
    max_devices = devices.select { |d| d[:ports] <= users }
    return [-1, users] if max_devices.empty?

    max_device = max_devices.max_by { |d| d[:ports] }
    [devices.index(max_device), max_device[:ports]]
  end

  def render_page(not_found)
    partial = not_found ? 'not_found' : 'devices'
    locals = not_found ? {} : { devices: @searched_devices, message: generate_message }
    render turbo_stream: turbo_stream.update('results', partial:, locals:)
  end

  def generate_message
    if @price > @budget
      "Not enough money. An additional $#{(@price - @budget).round(2)} is required."
    else
      "TOTAL COST: #{@price.round(2)}"
    end
  end
end
