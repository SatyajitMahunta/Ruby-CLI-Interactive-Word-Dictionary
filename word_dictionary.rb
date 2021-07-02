require 'net/http'
require 'json'
require_relative 'word_methods'
require_relative 'word_game'
require_relative 'credentials'

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
      puts Fetch_data
      word_definition(word)
    when "2"
      puts Fetch_data
      word_related(word)
    when "3"
      puts Fetch_data
      word_related(word)
    when "4"
      puts Fetch_data
      word_examples(word)
    when "5"
      puts Fetch_data
      word_full_dict(word)
    when "6"
      puts Fetch_data
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
