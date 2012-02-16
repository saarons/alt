# encoding: UTF-8

Dir["#{File.dirname(__FILE__)}/core_ext/*.rb"].sort.each do |path|
  require "alt/core_ext/#{File.basename(path, '.rb')}"
end