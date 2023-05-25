require 'readline'
require 'pathname'

module AutoComplete
  def self.try(input)
    current_path = Pathname.new(Dir.getwd)
    last_word = input.split(' ').last                                             # Extract the last word from the input
    directory_path = File.dirname(last_word)                                      # Get the directory path and the partial filename
    partial_filename = File.basename(last_word)
    absolute_path = current_path.join(directory_path).expand_path                 # Get the absolute path of the directory
    matching_files = Dir.glob(absolute_path.join("#{partial_filename}*"))         # Get the matching files in the directory

    if matching_files.length == 1                                                 # Add the matching filenames to the input
      input.sub!(/#{Regexp.escape(last_word)}$/, matching_files.first)            # If there is only one match, replace the last word with the full match
    elsif matching_files.length > 1
      puts "Autocomplete options:"                                                # If there are multiple matches, print them for selection
      matching_files.each { |file| puts file }
    end

    input
  end
end
