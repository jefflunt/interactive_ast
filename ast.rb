module Ast
  def self.traverse(node, indent = 0)
    puts "#{' ' * indent}#{node.type}"
    node.children.each { |child| traverse_ast(child, indent + 2) if child.is_a?(Parser::AST::Node) }
  end
end
