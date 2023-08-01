class StatelessReactionController
  def initialize
    @blubb = proc { |message| message.include?("blubb") }
    @hello = proc { |message| message.include?("hello") }
    @hungry = proc { |message| message.include?("I am hungry") }
  end    

  def stateless_reaction_to(message)
    case message.body
    when @blubb
      "blubbedi!"
    when @hello
      "hello"
    when @hungry
      provide_food_ideas
    end
  end

  def provide_food_ideas
    food_ideas = YAML.load_file 'food-ideas.yml'
    "I would recommend eating #{food_ideas[rand(food_ideas.size)]}"
  end
end
