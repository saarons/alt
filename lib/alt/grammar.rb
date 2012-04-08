# encoding: UTF-8

require "alt/core_ext/nil_class"

module Alt::Grammar
  class << self
    def keyword(kw)
      grammar[current_language]["keywords"].try(:[], kw)
    end
    
    def method(m, n)
      grammar[current_language]["methods"].try(:[], m).try(:[], n)
    end

    def current_language
      @language ||= "en"
    end
    
    def current_language=(language)
      @language = language
    end

    private
    def grammar
      @grammar ||= load_grammar
    end

    def load_grammar
      {}.tap do |languages|
        Dir.glob(File.expand_path("../../../etc/*.yml", __FILE__)) do |filename|
          language = File.basename(filename, ".yml")
          languages[language] = YAML.load_file(filename)
        end
      end
    end
  end
end