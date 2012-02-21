# encoding: UTF-8

require "alt/context"
require "alt/interpreter"

class Alt::Runtime
  def initialize(options = {})
    @options = options
  end
  
  def showtime
    setup if respond_to?(:setup)
    return_value = catch :return do
      run do |text|
        begin
          val = evaluate(text)
          handle_return_value(val) if respond_to?(:handle_return_value)
        rescue Alt::RuntimeError => e
          handle_error(e) if respond_to?(:handle_error)
        end
      end
    end
    cleanup(return_value) if respond_to?(:cleanup)
  end
  
  private
  def interpreter
    @interpreter ||= Alt::Interpreter.new(context)
  end
  
  def context
    @context ||= Alt::Context.new
  end
end

Dir["#{File.dirname(__FILE__)}/runtime/*.rb"].sort.each do |path|
  require "alt/runtime/#{File.basename(path, '.rb')}"
end