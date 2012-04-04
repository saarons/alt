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
  
  method("to_i") do |receiver, *arguments|
    s = receiver.value
    s = s.each_char.map { |c| FULLWIDTH_TO_ASCII.include?(c) ? FULLWIDTH_TO_ASCII[c] : c }.join
    Alt::Number.new(s)
  end
  
  def <=>(other)
    @value <=> other.value
  end
  
  def inspect
    '"' + @value.inspect[1..-2].gsub(Alt::Parser::QUOTE_REGEXP, '\\\\\0') + '"'
  end
end