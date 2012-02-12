# encoding: UTF-8

require "bundler/setup"

require "kpeg"

require "alt/version"
require "alt/ast/operator"
require "alt/ast/precedence"

begin
  require "grammar.kpeg.rb"
rescue LoadError
  file = File.expand_path("../grammar.kpeg", __FILE__)
  grammar = KPeg.load_grammar(file)
  cg = KPeg::CodeGenerator.new "Alt::Parser", grammar
  code = cg.output.prepend("# encoding: UTF-8\n")
  Object.module_eval code
end

module Alt
  def self.ast(program)
    parser = Parser.new(program)
    if parser.parse
      return parser.result
    end
  end
end