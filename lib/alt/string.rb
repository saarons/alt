# encoding: UTF-8

require "alt/value"
require "alt/number"

class Alt::String < Alt::Value
  include Comparable
  
  FULLWIDTH_TO_ASCII = Hash[(0xFF10..0xFF19).map { |c| [c].pack("U*") }.zip("0".."9")]
  
  attr_reader :value
  
  def initialize(value)
    @value = value
  end
  
  class << self
    def name
      "string"
    end
  end
  
  method("to_n") do |receiver, *arguments|
    s = receiver.value
    s = s.each_char.map { |c| FULLWIDTH_TO_ASCII.include?(c) ? FULLWIDTH_TO_ASCII[c] : c }.join
    Alt::Number.new(s)
  end

  method("length") do |receiver, *arguments|
    s = receiver.value
    Alt::Number.new(s.length)
  end

  method("to_lower") do |receiver, *arguments|
    s = receiver.value
    Alt::String.new(s.downcase)
  end
  
  method("to_upper") do |receiver, *arguments|
    s = receiver.value
    Alt::String.new(s.upcase)
  end

  method("subString") do |receiver, *arguments|
    s = receiver.value
    arg_1 = arguments[0].value
    arg_2 = arguments[1].value  
    Alt::String.new(s[arg_1,arg_2])
  end


  def <=>(other)
    @value <=> other.value
  end
  

  def inspect
    s = @value.dup
    s.gsub!(Alt::Parser::QUOTE_REGEXP, '\\\\\0')
    "\"#{s}\""
  end
end