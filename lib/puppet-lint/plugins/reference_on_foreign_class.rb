require 'pry'
PuppetLint.new_check(:reference_on_foreign_class) do
  def check
    has_declaration = 0
    tokens.select { |check_token|
      [:CLASSREF].include? check_token.type
    }.each do |check_token|
      check_classref = check_token.value.to_s.downcase
      check_title = check_token.next_token.next_token.value.to_s
      if check_classref == 'class'
        tokens.select { |token2|
          ( (token2.value.to_s == 'include' or token2.value.to_s == 'contain') and token2.next_code_token.value.to_s == check_title ) or ( token2.value.to_s == 'class' and token2.next_code_token.next_code_token.value.to_s == check_title)
        }.each do |token2|
          has_declaration = 1
        end
        if has_declaration == 0
          notify :warning, {
            :message => 'reference on a foreign class',
            :line    => check_token.line,
            :column  => check_token.column
          }
        end
      end
    end
  end
end
