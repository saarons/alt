# encoding: UTF-8

require "pp"
require "readline"
require "alt/runtime"

class Alt::Runtime::REPL < Alt::Runtime
  def handle_return_value(value)
    if value
      print "=> "
      pp value
    end
  end
  
  def handle_error(e)
    puts "ERROR: #{e}"
  end
  
  def setup
    puts "alt #{Alt::VERSION}"
  end
  
  def run
    while line = Readline::readline(">> ", true)
      yield line
    end
  end
  
  def evaluate(line)
    interpreter.eval(line)
  end
end