require 'active_record'
require 'pry'

require './lib/event'


ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

def header
  system 'clear'
  puts "*" * 50
  puts "Super Event Calendar 90XX"
  puts "*" * 50
  puts "\n\n"
end

def main_menu
  header
  puts "A > Add Event"
  puts "V > View Calendar"
  puts "E > Exit"

  case (gets.chomp.upcase)
  when 'A'
    add_event
  when 'V'
    view_menu
  when 'E'
    puts "Have an excellent day!"
    Exit
  else
    puts "Invalid menu option."
    sleep 1
  end
  main_menu
end

def add_event
  header
  puts "Please enter event description"
  name = gets.chomp.capitalize
  puts "Please enter the location"
  loc = gets.chomp
  puts "Please enter start date (YYYY-MM-DD HH:MM:SS)"
  s_date = gets.chomp
  puts "Please enter end date (YYYY-MM-DD HH:MM:SS)"
  e_date = gets.chomp
  new_event = Event.create({:name => name, :location => loc, :start_date => s_date, :end_date => e_date})
  puts "#{name} has been added to your calendar!"
end

def view_menu
  header
  puts "D > View by Day"
  puts "W > View by Week"
  puts "M > View by Month"
  case gets.chomp.upcase
  when 'D'
    view_day
  when 'W'
    view_week
  when 'M'
    view_month
  else
    puts "Invalid menu option."
    sleep 1
  end
end

def view_day
  header
  puts "Which day would you like to see (e.g. 1 for next day, 0 for this day)"
  selected_day = gets.chomp.to_i
  events = Event.todays_events(selected_day)
  events.each do |event|
    puts "#{event.name} #{event.location} Start: #{event.start_date} End: #{event.end_date}"
    puts "Press return to continue"
    gets
  end
end

def view_week
  header
  puts "Which week would you like to see (e.g. 1 for next week, 0 for this week)"
  selected_week = gets.chomp.to_i
  events = Event.week(selected_week)
  events.each do |event|
    puts "#{event.name} #{event.location} Start: #{event.start_date} End: #{event.end_date}"
  end
  puts "Press return to continue"
  gets
end

def view_month
  header
  puts "Which month would you like to see (e.g. 1 for next month, 0 for this month)"
  selected_month = gets.chomp.to_i
  events = Event.month(selected_month)
  events.each do |event|
    puts "#{event.name} #{event.location} Start: #{event.start_date} End: #{event.end_date}"
  end
  puts "Press return to continue"
  gets
end
main_menu
