require 'kpeg/compiled_parser'

class Alt::Parser < KPeg::CompiledParser

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
    class FalseLiteral < Node
      def initialize()
      end
    end
    class MethodCall < Node
      def initialize(receiver, method, arguments)
        @receiver = receiver
        @method = method
        @arguments = arguments
      end
      attr_reader :receiver
      attr_reader :method
      attr_reader :arguments
    end
    class NilLiteral < Node
      def initialize()
      end
    end
    class NumberLiteral < Node
      def initialize(number)
        @number = number
      end
      attr_reader :number
    end
    class TrueLiteral < Node
      def initialize()
      end
    end
  end
  def assign(name, expression)
    ::Alt::AST::Assignment.new(name, expression)
  end
  def false_literal()
    ::Alt::AST::FalseLiteral.new()
  end
  def method_call(receiver, method, arguments)
    ::Alt::AST::MethodCall.new(receiver, method, arguments)
  end
  def nil_literal()
    ::Alt::AST::NilLiteral.new()
  end
  def number_literal(number)
    ::Alt::AST::NumberLiteral.new(number)
  end
  def true_literal()
    ::Alt::AST::TrueLiteral.new()
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

  # newline = "\n"
  def _newline
    _tmp = match_string("\n")
    set_failed_rule :_newline unless _tmp
    return _tmp
  end

  # terminator = newline (space | newline)*
  def _terminator

    _save = self.pos
    while true # sequence
      _tmp = apply(:_newline)
      unless _tmp
        self.pos = _save
        break
      end
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_space)
          break if _tmp
          self.pos = _save2
          _tmp = apply(:_newline)
          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

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

  # operator_chars = /[~`!@#$\%^\&*\\+\-\/?:<=>\|]/
  def _operator_chars
    _tmp = scan(/\A(?-mix:[~`!@#$\%^\&*\\+\-\/?:<=>\|])/)
    set_failed_rule :_operator_chars unless _tmp
    return _tmp
  end

  # binary_operator = < operator_chars+ > { text }
  def _binary_operator

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _save1 = self.pos
      _tmp = apply(:_operator_chars)
      if _tmp
        while true
          _tmp = apply(:_operator_chars)
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

    set_failed_rule :_binary_operator unless _tmp
    return _tmp
  end

  # root = expressions
  def _root
    _tmp = apply(:_expressions)
    set_failed_rule :_root unless _tmp
    return _tmp
  end

  # expressions = (expressions:es terminator expression:e { es << e } | expressions:es terminator { es } | expression:e { [e] } | terminator)
  def _expressions

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_expressions)
        es = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_terminator)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_expression)
        e = @result
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  es << e ; end
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
        @result = begin;  es ; end
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
        _tmp = apply(:_expression)
        e = @result
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  [e] ; end
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

  # expression = (assign | call | literal | "(" expression:e ")" { e })
  def _expression

    _save = self.pos
    while true # choice
      _tmp = apply(:_assign)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_call)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_literal)
      break if _tmp
      self.pos = _save

      _save1 = self.pos
      while true # sequence
        _tmp = match_string("(")
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_expression)
        e = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = match_string(")")
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  e ; end
        _tmp = true
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_expression unless _tmp
    return _tmp
  end

  # literal = (number:n {number_literal(n)} | "true" {true_literal} | "false" {false_literal} | "nil" {nil_literal})
  def _literal

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_number)
        n = @result
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin; number_literal(n); end
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
        _tmp = match_string("true")
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin; true_literal; end
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
        _tmp = match_string("false")
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin; false_literal; end
        _tmp = true
        unless _tmp
          self.pos = _save3
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save4 = self.pos
      while true # sequence
        _tmp = match_string("nil")
        unless _tmp
          self.pos = _save4
          break
        end
        @result = begin; nil_literal; end
        _tmp = true
        unless _tmp
          self.pos = _save4
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_literal unless _tmp
    return _tmp
  end

  # call = (literal:l "." identifier:i "(" arg_list:al ")" {method_call(l, i, Array(al))} | literal:l "." identifier:i {method_call(l, i, [])} | expression:e "." identifier:i "(" arg_list:al ")" {method_call(e, i, Array(al))} | expression:e "." identifier:i {method_call(e, i, [])} | identifier:i "(" arg_list:al ")" {method_call(nil, i, Array(al))} | identifier:i {method_call(nil, i, [])})
  def _call

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_literal)
        l = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = match_string(".")
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_identifier)
        i = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = match_string("(")
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_arg_list)
        al = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = match_string(")")
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin; method_call(l, i, Array(al)); end
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
        _tmp = apply(:_literal)
        l = @result
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = match_string(".")
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_identifier)
        i = @result
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin; method_call(l, i, []); end
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
        _tmp = apply(:_expression)
        e = @result
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = match_string(".")
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = apply(:_identifier)
        i = @result
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = match_string("(")
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = apply(:_arg_list)
        al = @result
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = match_string(")")
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin; method_call(e, i, Array(al)); end
        _tmp = true
        unless _tmp
          self.pos = _save3
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save4 = self.pos
      while true # sequence
        _tmp = apply(:_expression)
        e = @result
        unless _tmp
          self.pos = _save4
          break
        end
        _tmp = match_string(".")
        unless _tmp
          self.pos = _save4
          break
        end
        _tmp = apply(:_identifier)
        i = @result
        unless _tmp
          self.pos = _save4
          break
        end
        @result = begin; method_call(e, i, []); end
        _tmp = true
        unless _tmp
          self.pos = _save4
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save5 = self.pos
      while true # sequence
        _tmp = apply(:_identifier)
        i = @result
        unless _tmp
          self.pos = _save5
          break
        end
        _tmp = match_string("(")
        unless _tmp
          self.pos = _save5
          break
        end
        _tmp = apply(:_arg_list)
        al = @result
        unless _tmp
          self.pos = _save5
          break
        end
        _tmp = match_string(")")
        unless _tmp
          self.pos = _save5
          break
        end
        @result = begin; method_call(nil, i, Array(al)); end
        _tmp = true
        unless _tmp
          self.pos = _save5
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save6 = self.pos
      while true # sequence
        _tmp = apply(:_identifier)
        i = @result
        unless _tmp
          self.pos = _save6
          break
        end
        @result = begin; method_call(nil, i, []); end
        _tmp = true
        unless _tmp
          self.pos = _save6
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_call unless _tmp
    return _tmp
  end

  # arg_list = (expression | arg_list:al "," expression:e { Array(al) << e })
  def _arg_list

    _save = self.pos
    while true # choice
      _tmp = apply(:_expression)
      break if _tmp
      self.pos = _save

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_arg_list)
        al = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = match_string(",")
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_expression)
        e = @result
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  Array(al) << e ; end
        _tmp = true
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_arg_list unless _tmp
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
  Rules[:_newline] = rule_info("newline", "\"\\n\"")
  Rules[:_terminator] = rule_info("terminator", "newline (space | newline)*")
  Rules[:_number] = rule_info("number", "< digit+ > { text }")
  Rules[:_identifier] = rule_info("identifier", "< char+ > { text }")
  Rules[:_operator_chars] = rule_info("operator_chars", "/[~`!@\#$\\%^\\&*\\\\+\\-\\/?:<=>\\|]/")
  Rules[:_binary_operator] = rule_info("binary_operator", "< operator_chars+ > { text }")
  Rules[:_root] = rule_info("root", "expressions")
  Rules[:_expressions] = rule_info("expressions", "(expressions:es terminator expression:e { es << e } | expressions:es terminator { es } | expression:e { [e] } | terminator)")
  Rules[:_expression] = rule_info("expression", "(assign | call | literal | \"(\" expression:e \")\" { e })")
  Rules[:_literal] = rule_info("literal", "(number:n {number_literal(n)} | \"true\" {true_literal} | \"false\" {false_literal} | \"nil\" {nil_literal})")
  Rules[:_call] = rule_info("call", "(literal:l \".\" identifier:i \"(\" arg_list:al \")\" {method_call(l, i, Array(al))} | literal:l \".\" identifier:i {method_call(l, i, [])} | expression:e \".\" identifier:i \"(\" arg_list:al \")\" {method_call(e, i, Array(al))} | expression:e \".\" identifier:i {method_call(e, i, [])} | identifier:i \"(\" arg_list:al \")\" {method_call(nil, i, Array(al))} | identifier:i {method_call(nil, i, [])})")
  Rules[:_arg_list] = rule_info("arg_list", "(expression | arg_list:al \",\" expression:e { Array(al) << e })")
  Rules[:_assign] = rule_info("assign", "identifier:i space* \"=\" space* expression:e {assign(i,e)}")
end
