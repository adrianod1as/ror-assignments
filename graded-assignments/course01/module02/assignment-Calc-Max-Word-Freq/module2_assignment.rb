#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class. 
  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content          - the string analyzed (provided)g
  #* line_number      - the line number analyzed (provided)
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  #Add the following methods in the LineAnalyzer class.
 
  #* initialize() - taking a line of text (content) and a line number
 
  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.
  def initialize (content, line_number)
    @content = content
    @line_number = line_number
    calculate_word_frequency
  end

  #split string into words
  #create hash |word, frequency|
  #returns hash
  def count_words (string)
    words = string.scan(/\w+/)
    frequency = Hash.new(0)
    words.each { |word| frequency[word.downcase] += 1 }
    frequency
  end

  #* calculate_word_frequency() - calculates result
  
  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.
  def calculate_word_frequency
    frequency = count_words(@content)
    @highest_wf_count = frequency.values.max
    @highest_wf_words= frequency.map{ |k,v| v==@highest_wf_count ? k : nil }.compact
  end


end

#  Implement a class called Solution. 
class Solution

  # Implement the following read-only attributes in the Solution class.
  #* analyzers - an array of LineAnalyzer objects for each line in the file
  #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute 
  #  equal to the highest_count_across_lines determined previously.
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize
    @analyzers = []
  end


  # Implement the following methods in the Solution class.

  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.

  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines 
  #* Create an array of LineAnalyzers for each line in the file
  def analyze_file
    line_number = 0
    f = 'test.txt'
    if File.exist? f
      File.foreach(f) do |line|
        line_analyzer = LineAnalyzer.new(line.chomp, line_number)
        @analyzers << line_analyzer
        line_number+=1
      end
    end
    
     # p @analyzers[0].highest_wf_words
    # puts objects_frequecy = mapAnalyzers
    # puts objects_frequecy.values.max
    # puts objects_frequecy.map{ |k,v| v==objects_frequecy.values.max ? k : nil }.compact
    # puts objects_frequecy
  end

  #create Hash |analyzer, highest_wf_count|
  #return Hash
  def mapAnalyzers
    objects_frequecy = Hash.new(0)
    @analyzers.each do |analyzer| 
      objects_frequecy[analyzer] = analyzer.highest_wf_count
    end
    objects_frequecy
  end

  #* calculate_line_with_highest_frequency() - determines the highest_count_across_lines and 
  #  highest_count_words_across_lines attribute values

  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines 
  #  attribute value determined previously and stores them in highest_count_words_across_lines.
  def calculate_line_with_highest_frequency
    analyzers_frequency = mapAnalyzers
    @highest_count_across_lines = analyzers_frequency.values.max
    @highest_count_words_across_lines = analyzers_frequency.map{ |k,v| v==@highest_count_across_lines ? k : nil }.compact

  end

  #* print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in 
  #  highest_count_words_across_lines in the specified format

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format

  # The following words have the highest word frequency per line:

  # ["word1"] (appears in line #)

  # ["word2", "word3"] (appears in line #)

  def print_highest_word_frequency_across_lines
    calculate_line_with_highest_frequency
    puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each do |analyzer|
      puts "#{analyzer.highest_wf_words} (appears in line #{analyzer.line_number})" 
    end

  end
  


end

solution = Solution.new()
solution.analyze_file
# solution.print_highest_word_frequency_across_lines

