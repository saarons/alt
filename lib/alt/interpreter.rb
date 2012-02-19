# encoding: UTF-8

require "alt/context"

class Alt::Interpreter
  def initialize
    @context = Alt::Context.new
  end

  def eval(code)
    parser = Alt::Parser.new(code)
    if parser.parse
      return parser.result.eval(@context)
    end
  end
end