# encoding: UTF-8

Dir["#{File.dirname(__FILE__)}/ast/*.rb"].sort.each do |path|
  require "alt/ast/#{File.basename(path, '.rb')}"
end