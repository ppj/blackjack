module Prompt

  def prompt(string, default)
    if default.empty?
      prompt_string = "#{string} >> "
    else
      prompt_string = "#{string} (Default: '#{default}') >> "
    end
    print prompt_string
    response = gets.chomp
    if response.empty?
      response = default
    end
    response
  end

end