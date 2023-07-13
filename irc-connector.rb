require "socket"
require "yaml"

class IRCConnector
  def initialize
    @joined = false
    settings = YAML.load_file 'settings.yml'
    @server = settings['SERVER']
    @port = settings['PORT']
    @channel = settings['CHANNEL']
    @name = settings['NAME']
  end

  def connect
    @socket = TCPSocket.open(@server, @port)
    send("NICK #{@name}")
    send("USER #{@name} 0 * :#{@name}")
  end

  def listen_for_messages(abbonoment_receiver)
    until @socket.eof? do
      message = @socket.gets
      log_to_console message
      keep_connection_alive if message.start_with?("PING")
      join_channel if !@joined && message.include?("MODE #{@name}")
      abbonoment_receiver.call(message) if message.include?("PRIVMSG #{@channel}")
    end
  end
  
  def join_channel
    send("JOIN #{@channel}")
    @joined = true
  end

  def keep_connection_alive
    challenge = message.split(" ").last
    @irc_connector.irc_send "PONG #{challenge}"
  end

  def send(message)
    log_to_console "Sending: #{message}"
    @socket.puts(message)
  end

  def log_to_console(log_message)
    puts log_message
  end
end