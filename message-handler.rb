require_relative './irc-connector.rb'

class MessageHandler
  def initialize
    @irc_connector = IRCConnector.new
    @irc_connector.connect
    @irc_connector.listen_for_messages(self.method(:receive))
  end

  def receive(message)
    handle_channel_message(message)
  end

  def handle_channel_message(message)
    @irc_connector.send("PRIVMSG #rubymonstas :blubb")
  end
end

