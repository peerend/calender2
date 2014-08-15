require 'active_record'
require 'pry'

require 'event'


ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

def header
  system 'clear'
  puts "*" * 50
  puts "Super Event Calendar 90XX"
  puts "*" * 50
  puts "\n\n"
end

def main_menu
  puts "A > Add Event"
  puts "V > View Calendar"
  puts "E > Exit"

  case (gets.chomp.upcase)
  when 'A'
    add_event
  when 'V'
    view_calendar
  when 'E'
    puts "Have an excellent day!"
    Exit
  end
end

def add_event
  puts "Please enter event description"
  name = gets.chomp
  puts "Please enter the location"
  loc = gets.chomp
  puts "Please enter start date (YYYY-MM-DD HH:MM:SS)"

end

def view_calendar

end
main_menu
