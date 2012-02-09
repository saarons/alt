require 'kpeg/compiled_parser'

class Alt::Parser < KPeg::CompiledParser


	attr_accessor :ast



  module ::Alt::AST
    class Node; end
    class Assignment < Node
      def initialize(name, expression)
        @name = name
        @expression = expression
      end
      attr_reader :name
      attr_reader :expression
    end
    class NumberLiteral < Node
      def initialize(number)
        @number = number
      end
      attr_reader :number
    end
  end
  def assign(name, expression)
    ::Alt::AST::Assignment.new(name, expression)
  end
  def number_literal(number)
    ::Alt::AST::NumberLiteral.new(number)
  end

  # space = " "
  def _space
    _tmp = match_string(" ")
    set_failed_rule :_space unless _tmp
    return _tmp
  end

  # char = /[A-Za-z]/
  def _char
    _tmp = scan(/\A(?-mix:[A-Za-z])/)
    set_failed_rule :_char unless _tmp
    return _tmp
  end

  # digit = /[0-9]/
  def _digit
    _tmp = scan(/\A(?-mix:[0-9])/)
    set_failed_rule :_digit unless _tmp
    return _tmp
  end

  # terminator = "\n"
  def _terminator
    _tmp = match_string("\n")
    set_failed_rule :_terminator unless _tmp
    return _tmp
  end

  # number = < digit+ > { text }
  def _number

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _save1 = self.pos
      _tmp = apply(:_digit)
      if _tmp
        while true
          _tmp = apply(:_digit)
          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  text ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_number unless _tmp
    return _tmp
  end

  # identifier = < char+ > { text }
  def _identifier

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _save1 = self.pos
      _tmp = apply(:_char)
      if _tmp
        while true
          _tmp = apply(:_char)
          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  text ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_identifier unless _tmp
    return _tmp
  end

  # root = expressions:e { @ast = e }
  def _root

    _save = self.pos
    while true # sequence
      _tmp = apply(:_expressions)
      e = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  @ast = e ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_root unless _tmp
    return _tmp
  end

  # expressions = (expression:e { [e] } | expressions:es terminator expression:e { es << e } | expressions:es terminator { es } | terminator)
  def _expressions

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_expression)
        e = @result
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  [e] ; end
        _tmp = true
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save2 = self.pos
      while true # sequence
        _tmp = apply(:_expressions)
        es = @result
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_terminator)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_expression)
        e = @result
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  es << e ; end
        _tmp = true
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save3 = self.pos
      while true # sequence
        _tmp = apply(:_expressions)
        es = @result
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = apply(:_terminator)
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  es ; end
        _tmp = true
        unless _tmp
          self.pos = _save3
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      _tmp = apply(:_terminator)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_expressions unless _tmp
    return _tmp
  end

  # expression = (literal | assign)
  def _expression

    _save = self.pos
    while true # choice
      _tmp = apply(:_literal)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_assign)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_expression unless _tmp
    return _tmp
  end

  # literal = number:n {number_literal(n)}
  def _literal

    _save = self.pos
    while true # sequence
      _tmp = apply(:_number)
      n = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; number_literal(n); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_literal unless _tmp
    return _tmp
  end

  # assign = identifier:i space* "=" space* expression:e {assign(i,e)}
  def _assign

    _save = self.pos
    while true # sequence
      _tmp = apply(:_identifier)
      i = @result
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_space)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("=")
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_space)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_expression)
      e = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; assign(i,e); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_assign unless _tmp
    return _tmp
  end

  Rules = {}
  Rules[:_space] = rule_info("space", "\" \"")
  Rules[:_char] = rule_info("char", "/[A-Za-z]/")
  Rules[:_digit] = rule_info("digit", "/[0-9]/")
  Rules[:_terminator] = rule_info("terminator", "\"\\n\"")
  Rules[:_number] = rule_info("number", "< digit+ > { text }")
  Rules[:_identifier] = rule_info("identifier", "< char+ > { text }")
  Rules[:_root] = rule_info("root", "expressions:e { @ast = e }")
  Rules[:_expressions] = rule_info("expressions", "(expression:e { [e] } | expressions:es terminator expression:e { es << e } | expressions:es terminator { es } | terminator)")
  Rules[:_expression] = rule_info("expression", "(literal | assign)")
  Rules[:_literal] = rule_info("literal", "number:n {number_literal(n)}")
  Rules[:_assign] = rule_info("assign", "identifier:i space* \"=\" space* expression:e {assign(i,e)}")
end