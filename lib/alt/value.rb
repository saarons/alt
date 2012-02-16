module Alt
  class Value
    def self.alt_methods
      @alt_methods ||= {}
    end
    
    def [](name, *args)
      self.class.alt_methods[name].call(self, *args)
    end
  end
end