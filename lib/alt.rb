require "rubygems"
require "bundler/setup"

require "kpeg"

require "alt/version"
require "alt/ast/operator"
require "alt/ast/precedence"

begin
  require "grammar.kpeg.rb"
rescue LoadError
  KPeg.load File.expand_path("../grammar.kpeg", __FILE__), "Alt::Parser"
end

module Alt
  def self.ast(program)
    parser = Parser.new(program)
    if parser.parse
      return parser.result
    end
  end
end