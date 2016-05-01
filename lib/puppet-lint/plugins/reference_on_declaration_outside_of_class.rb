PuppetLint.new_check(:reference_on_declaration_outside_of_class) do
  def check
    has_declaration = 0
    resource_indexes.each do |resource|
      resource[:tokens].select { |token|
        [:CLASSREF].include? token.type
      }.each do |token|
        check_classref = token.value.to_s.downcase
        check_title = token.next_token.next_token.value.to_s
        tokens.select { |token2|
          token2.value.to_s == check_classref and token2.next_token.next_token.next_token.next_token.value.to_s == check_title
        }.each do |token2|
          has_declaration = 1
        end
        if has_declaration == 0
          notify :warning, {
            :message => 'reference on a resource type declaration not included in the same class',
            :line    => token.line,
            :column  => token.column
          }
        end
      end
    end
    tokens.select { |check_token|
      [:CLASSREF].include? check_token.type
    }.each do |check_token|
      check_classref = check_token.value.to_s.downcase
      check_title = check_token.next_token.next_token.value.to_s
      if check_classref == 'class'
        tokens.select { |token2|
          token2.value.to_s == 'include' and token2.next_token.next_token.value.to_s == check_title
        }.each do |token2|
          has_declaration = 1
        end
        if has_declaration == 0
          notify :warning, {
            :message => 'reference on a resource type declaration not included in the same class',
            :line    => check_token.line,
            :column  => check_token.column
          }
        end
      end
    end
  end
end
