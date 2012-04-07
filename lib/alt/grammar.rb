module Alt::Grammar
  def self.[](name)
    grammar[name]
  end
  
  private
  def self.grammar
    @grammar ||= load_grammar
  end
  
  def self.load_grammar
    {"break" => "break"}
  end
end