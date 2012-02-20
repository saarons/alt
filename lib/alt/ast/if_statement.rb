# encoding: UTF-8

class Alt::AST::IfStatement
  def eval(context)
    fallback = lambda { [nil, @fallback || Alt::AST::NilLiteral.new] }
    branch = @conditionals.find(fallback) { |(c, b)| c.eval(context).to_boolean }
    branch[1].eval(context)
  end
end