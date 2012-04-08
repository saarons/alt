# encoding: UTF-8

require "alt/object"

class Alt::AST::ObjectLiteral
  def eval(context)
    Alt::Object.new(@object.reduce({}) { |memo, (k, v)| memo.merge(k.eval(context) => v.eval(context)) })
  end
end