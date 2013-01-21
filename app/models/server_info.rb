class ServerInfo

  attr_accessor :server, :server_connection

  def initialize(server)
    @server            = server
    @server_connection = SteamCondenser::SourceServer.new(@server.ip, @server.port.to_i)
  end

  def auth
    server_connection.rcon_auth(server.current_rcon)
  end

  def server_name
    status.fetch(:server_name,        'unknown')
  end

  def number_of_players
    status.fetch(:number_of_players,  '0')
  end

  def max_players
    status.fetch(:max_players,        '0')
  end

  def map_name
    status.fetch(:map_name,           'unknown')
  end

  def status
    Rails.cache.fetch "status_#{server.id}" do
      server_connection.server_info.delete_if {|key| key == :content_data }
    end
  end

  def get_stats
    Rails.cache.fetch "stats_#{server.id}" do
      server_connection.rcon_exec('stats')
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

  def connect
    stats[:connect]
  end

  def stats
    stats_line = ""
    get_stats.each_line do |line|
      stats_line = line
    end
    #CPU    In (KB/s)  Out (KB/s)  Uptime  Map changes  FPS      Players  Connects\n24.88  35.29      54.48       6       2            66.67    9        12"
    items = stats_line.split(" ")
    {
      :cpu          => items[-8],
      :in           => items[-7],
      :out          => items[-6],
      :uptime       => items[-5],
      :map_changes  => items[-4],
      :fps          => items[-3],
      :connect      => items[-1]
    }
  end

end