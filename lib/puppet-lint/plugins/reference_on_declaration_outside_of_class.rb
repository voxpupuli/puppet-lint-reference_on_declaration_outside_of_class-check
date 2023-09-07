PuppetLint.new_check(:reference_on_declaration_outside_of_class) do
  def check
    has_declaration = 0
    resource_indexes.each do |resource|
      resource[:tokens].select do |token|
        [:CLASSREF].include? token.type
      end.each do |token|
        check_classref = token.value.to_s.downcase
        check_title = token.next_token.next_token.value.to_s
        tokens.select do |token2|
          token2.value.to_s == check_classref and token2.next_token.next_token.next_token.next_token.value.to_s == check_title
        end.each do |_token2|
          has_declaration = 1
        end
        next unless has_declaration == 0

        notify :warning, {
          message: 'reference on a resource type declaration not included in the same class',
          line: token.line,
          column: token.column,
        }
      end
    end
    tokens.select do |check_token|
      [:CLASSREF].include? check_token.type
    end.each do |check_token|
      check_classref = check_token.value.to_s.downcase
      check_title = check_token.next_token.next_token.value.to_s
      next unless check_classref == 'class'

      tokens.select do |token2|
        token2.value.to_s == 'include' and token2.next_token.next_token.value.to_s == check_title
      end.each do |_token2|
        has_declaration = 1
      end
      next unless has_declaration == 0

      notify :warning, {
        message: 'reference on a resource type declaration not included in the same class',
        line: check_token.line,
        column: check_token.column,
      }
    end
  end
end
