# encoding: UTF-8

require "singleton"
require "alt/value"

class Alt::True < Alt::Value
  include Singleton
end

class Alt::False < Alt::Value
  include Singleton
end

class Alt::Nil < Alt::Value
  include Singleton
end