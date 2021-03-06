class ServerInfo

  attr_accessor :server, :server_connection

  delegate :condenser, :to => :server, :prefix => false

  def initialize(server)
    @server            = server
    @server_connection = condenser
  end

  def auth
    server.rcon_auth
  end

  def server_name
    ActiveSupport::Multibyte::Chars.new(status.fetch(:server_name, 'unknown')).tidy_bytes.to_s
  end

  def number_of_players
    status.fetch(:number_of_players,  nil)
  end

  def max_players
    status.fetch(:max_players,        '0')
  end

  def map_name
    status.fetch(:map_name,           'unknown')
  end

  def status
    Rails.cache.fetch "server_info_#{server.id}", expires_in: 1.minute do
      begin
        info = server_connection.server_info
        info.delete_if {|key| key == :content_data }
      rescue SteamCondenser::Error
        {}
      end
    end
  end

  def get_stats
    Rails.cache.fetch "stats_#{server.id}", expires_in: 1.minute do
      auth
      server_connection.rcon_exec('stats')
    end
  end

  def get_rcon_status
    Rails.cache.fetch "rcon_status_#{server.id}", expires_in: 1.minute do
      auth
      ActiveSupport::Multibyte::Chars.new(server_connection.rcon_exec('status')).to_s
    end
  end

  def cpu
    stats[:cpu]
  end

  def traffic_in
    stats[:in]
  end

  def traffic_out
    stats[:out]
  end

  def uptime
    stats[:uptime]
  end

  def map_changes
    stats[:map_changes]
  end

  def fps
    stats[:fps]
  end

  def connects
    stats[:connects]
  end

  def stats
    stats_line = ""
    #CPU    In (KB/s)  Out (KB/s)  Uptime  Map changes  FPS      Players  Connects
    #24.88  35.29      54.48       6       2            66.67    9        12
    get_stats.each_line do |line|
      stats_line = line
    end
    items = stats_line.split(" ")
    {
      :cpu          => items[-8],
      :in           => items[-7],
      :out          => items[-6],
      :uptime       => items[-5],
      :map_changes  => items[-4],
      :fps          => items[-3],
      :connects     => items[-1]
    }
  end

end
