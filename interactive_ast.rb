require_relative './autocomplete'
require_relative './ast'
require 'parser/current'

# Handle Ctrl+C
trap('INT') do
  puts "\nBye."
  exit 1
end

def traverse_ast(node, indent = 0)
  puts "#{' ' * indent}#{node.type}"
  node.children.each { |child| traverse_ast(child, indent + 2) if child.is_a?(Parser::AST::Node) }
end

loop do
  input = Readline.readline('> ', true)

  # Exit the loop if the user presses Ctrl+C or enters 'exit'
  break if input.nil? || input.downcase.strip == 'exit'

  # Check if TAB key is pressed
  if input.end_with?("\t")
    input = AutoComplete.file(input.chomp("\t"))
    puts "> #{input}"
  end

  input.strip!

  if File.exist?(input) && input.end_with?('.rb')
    Ast.traverse(Parser::CurrentRuby.parse(IO.read(input)))
  else
    puts "Error: file not found, or it's not a Ruby file: `#{input}'"
  end
end
