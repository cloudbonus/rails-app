class PagesController < ApplicationController
  def index
    @net_devices = NetworkDevice.none
  end

  def search
    @budget = params[:price].to_f
    @users = params[:users].to_i
    bandwidth = params[:bandwidth].to_i

    # @type [Array]
    @net_devices = find_devices(bandwidth, @budget)

    routers = @net_devices.select { |device| device if device[:d_type] == 'router' }
    switches = @net_devices.select { |device| device if device[:d_type] == 'switch' }
    cables = @net_devices.select { |device| device if device[:d_type] == 'cable' }

    if routers.empty? || switches.empty?
      message = 'Configuration is not found'
      render turbo_stream: turbo_stream.update('results', partial: 'absent', locals: { message: })
      return
    end

    routers, routers_price = get_devices(routers)
    switches, switches_price = get_devices(switches)
    cables, cables_price = get_devices(cables)

    render_page(routers + switches + cables, routers_price + switches_price + cables_price)
  end

  def find_devices(bandwidth, budget)
    NetworkDevice.where('bandwidth >= ? AND price <= ?', bandwidth, budget).order(ports: :desc)
  end

  # @param [Array] devices
  def get_devices(devices, users_tmp = @users)
    total_price = 0
    result_devices = []
    while users_tmp.positive? && total_price <= @budget
      max_n, max_users = get_with_max_users(devices, users_tmp)
      result_devices.append(devices[max_n])
      users_tmp -= max_users
      total_price += devices[max_n][:price]
    end
    [result_devices, total_price]
  end

  def get_with_max_users(devices, users = 0)
    max_users = Integer
    max_n = Integer
    return [-1, users] if users < devices.map { |device| device[:ports] }.min

    devices.each_with_index do |i, j|
      next unless i[:ports] <= users

      max_users = i[:ports]
      max_n = j
      break
    end
    [max_n, max_users]
  end

  def render_page(devices, price)
    if price > @budget
      message = "Not enough money. An additional $#{(price - @budget).round(2)} is required."
      render turbo_stream: turbo_stream.update('results', partial: 'absent', locals: { message: })
    else
      price = price.round(2)
      render turbo_stream: turbo_stream.update('results', partial: 'devices', locals: { devices:, price: })
    end
  end
end
