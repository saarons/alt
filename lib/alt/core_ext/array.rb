# encoding: UTF-8

class Array
  def eval
    self.map(&:eval)
  end
end