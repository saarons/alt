# encoding: UTF-8

require "singleton"

class Alt::True
  include Singleton
end

class Alt::False
  include Singleton
end

class Alt::Nil
  include Singleton
end