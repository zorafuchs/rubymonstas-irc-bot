# customize the name of your bot on the following line
@name = "blubbedi_bot"

@blubb = proc { |message| message.include?("blubb") }
@hello = proc { |message| message.include?("hello") }
@hungry = proc { |message| message.include?("I'm hungry") }

def send_to_ruby_monstas_channel(message_to_send)
  irc_send("PRIVMSG #rubymonstas :" + message_to_send)
end

def provide_food_ideas
  food_ideas = YAML.load_file 'food-ideas.yml'
  send_to_ruby_monstas_channel("I would recommend eating #{food_ideas[rand(food_ideas.size)]}")
end

# This method gets called, whenever a message is sent to our IRC channel. In it you can react to
# the users' inputs in whatever way you like...
def handle_channel_message(message)
  # Implement your ideas here. 
  # The string in `message` will look something like this: 
  # ":nerdinand!b2c5e1f5@gateway/web/freenode/ip.178.197.225.245 PRIVMSG #rubymonstas :Look at me, I'm here!"
  # 
  # You can use the method `irc_send` to send strings to the IRC server, e.g.
  
  case message
  when @blubb
    send_to_ruby_monstas_channel("blubbedi!")
  when @hello
    send_to_ruby_monstas_channel("hello")
  when @hungry
    provide_food_ideas
  end
end

require_relative './irc_magic.rb'
