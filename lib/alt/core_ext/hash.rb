# encoding: UTF-8

require "alt/object"

class Hash
  def to_alt
    Alt::Object.new(reduce({}) { |memo, (k, v)| memo.merge(k.to_alt => v.to_alt) })
  end
end