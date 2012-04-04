# encoding: UTF-8

class Alt::Parser < KPeg::CompiledParser  
  QUOTE_REGEXP = /'|\"|\p{Initial_Punctuation}|\p{Final_Punctuation}/
  QUOTE_STRING = QUOTE_REGEXP.source.gsub("|", "")
  NOT_QUOTE = Regexp.new("[^#{QUOTE_STRING}]")
  ESCAPED_QUOTE = Regexp.new("\\\\([#{QUOTE_STRING}])")
end