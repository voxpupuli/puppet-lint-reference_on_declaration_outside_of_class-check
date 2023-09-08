PuppetLint.new_check(:reference_on_foreign_class) do
  def check
    has_declaration = 0
    tokens.select do |check_token|
      %i[CLASSREF TYPE].include? check_token.type
    end.each do |check_token|
      check_classref = check_token.value.to_s.downcase
      check_title = check_token.next_token.next_token.value.to_s
      next unless check_classref == 'class'

      tokens.select do |token2|
        ((token2.value.to_s == 'include' or token2.value.to_s == 'contain') and token2.next_code_token.value.to_s == check_title) or (token2.value.to_s == 'class' and token2.next_code_token.next_code_token.value.to_s == check_title)
      end.each do |_token2|
        has_declaration = 1
      end
      next unless has_declaration == 0

      notify :warning, {
        message: 'reference on a foreign class',
        line: check_token.line,
        column: check_token.column,
      }
    end
  end
end
