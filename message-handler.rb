require_relative './irc-connector.rb'
require_relative './stateless-reaction-controller.rb'

class MessageHandler
  def initialize
    @stateless_reaction_controller = StatelessReactionController.new
    @irc_connector = IRCConnector.new
    @irc_connector.connect
    @irc_connector.listen_for_messages(self.method(:receive))
  end

  def receive(message)
    handle_stateless(message)
  end

  def handle_stateless(message)
    @irc_connector.send("PRIVMSG #rubymonstas :" + @stateless_reaction_controller.stateless_reaction_to(message)) if @stateless_reaction_controller.stateless_reaction_to(message) 
  end
end
