class Event < ActiveRecord::Base
  has_many :notes

  def self.remove_old_events
    future = []
    events = Event.order(:start_date)
    events.each do |event|
      if event.start_date > Time.now
        future << event
      end
    end
    future
  end

  def self.todays_events(input)
    today = []
    t = Time.now + input.day
    events = Event.order(:start_date)
    events.each do |event|
      if event.start_date.day == t.day
        today << event
      end
    end
    today
  end

  def self.week(input)
    week_events = []
    t = Time.now + (input * 7).day
    sunday = (7 - t.wday) + t.day
    events = Event.order(:start_date)
    events.each do |event|
      if (event.start_date >= t) && (event.start_date.day <= sunday) && (event.start_date < (t + 7.day))
        week_events << event
      end
    end
    week_events
  end
  def self.month(input)
    month_events = []
    t = Time.now + input.month
    events = Event.order(:start_date)
    events.each do |event|
      if (event.start_date.month == t.month)
        month_events << event
      end
    end
    month_events
  end
end
