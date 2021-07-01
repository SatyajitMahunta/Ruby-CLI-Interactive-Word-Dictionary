require 'net/http'
require 'json'
require_relative 'word_methods'
require_relative 'word_game'

#Variables
API_KEY = "fb8007781a73a8884e3821dc8f330cf2949b422d2a4be2bac9f1d5def50213d48f04cf2869255230d8e5adc4bee08ed27035a7a65745b5184b37848e93a691c099b93b1b072f24ad7908352ed10947e3"
Options = "1. Word Definitions\n2. Word Synonyms\n3. Word Antonyms\n4. Word Examples\n5. Word Full Dict\n6. Word of the Day Full Dict\n7. Word Game\n8. Exit\n\n"
Intro = "\n\n Welcome to the word dictionary, You can do the following opertions on this dictionary : \n\n"

# This Below method prints the ASCII art, which is present in ASCII_Art.txt file
def render_ascii_art
  File.open("ASCII_Art.txt" , "r") do |file|
    puts file.read()
  end
end
render_ascii_art
puts Intro

def check_isPresent(word)
  link = URI "https://fourtytwowords.herokuapp.com/word/#{word}/definitions?api_key=" + API_KEY
  # Extract the data
  data = extract_content(link)
  if !data.instance_of?Array
    puts "WORD IS NOT PRESENT IN THE DICTIONARY :( \n\n" 
    return false
  end
  
  return true  
end  
while true
  puts Options
  choice = gets.chomp()
  word = ''
  if choice.to_i >= 1 && choice.to_i <= 5
    puts "Please enter the word :"

    word = gets.chomp()
    if(word.length() > 0)
      if(!check_isPresent(word))
       next
      end   
    end  
  end  
  
  case choice
    when "1"
      word_definition(word)
    when "2"
      word_related(word)
    when "3"
      word_related(word)
    when "4"
      word_examples(word)
    when "5"
      word_full_dict(word)
    when "6"
      word_of_the_day 
    when "7"
      puts "Game Scoring :: ʕ•ᴥ•ʔ
      Each correct answer gives 10 points.
      Each hint reduces 3 point.
      Each wrong try reduces 2 points.
      Skip reduces 4 points.
      "
      puts "\nGAME LOADING......[PLEASE WAIT]\n\n"
      word_game
    when "8"
      exit
      break
    else
      puts "Invalid Option Selected."         
  end                  
end    
