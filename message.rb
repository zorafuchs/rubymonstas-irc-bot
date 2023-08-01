class Message
  attr_reader :user, :command, :body
  attr_accessor :session

  def initialize(message_string)
    capturing_groups = message_string.match /^:([^!]*)![^:]*:([^:]*):?[ ]*(.*)/
    @user = capturing_groups[1]
    @body = capturing_groups[3]
    @command = capturing_groups[2] if @body != ''
    @body = capturing_groups[2] if @body == ''
    
  end
end