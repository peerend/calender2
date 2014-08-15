require 'spec_helper'

describe 'Event' do
  it 'sorts all entered events by start date' do
    event1 = Event.create({:start_date => (Time.now + 1.day), :end_date => '2014-05-03 12:22:00 -0700', :location => 'here' })
    event2 = Event.create({:start_date => (Time.now - 1.day), :end_date => '2014-09-03 12:22:00 -0700', :location => 'here' })
    event3 = Event.create({:start_date => (Time.now + 2.day), :end_date => '2014-010-03 12:22:00 -0700', :location => 'here' })
    events = Event.order(:start_date)
    expect(events).to eq [event2, event1, event3]
  end

  it 'sorts all entered events starting after today by start date' do
    event1 = Event.create({:start_date => (Time.now + 1.day), :end_date => '2014-05-03 12:22:00 -0700', :location => 'here' })
    event3 = Event.create({:start_date => (Time.now - 1.day), :end_date => '2014-10-03 12:22:00 -0700', :location => 'here' })
    event2 = Event.create({:start_date => (Time.now + 2.day), :end_date => '2014-09-03 12:22:00 -0700', :location => 'here' })
    events = Event.remove_old_events
    expect(events).to eq [event1, event2]
  end

  it 'sorts all entered events returning only those happening today' do
    event1 = Event.create({:start_date => (Time.now + 5), :end_date => '2014-05-03 12:22:00 -0700', :location => 'here' })
    event3 = Event.create({:start_date => (Time.now), :end_date => '2014-10-03 12:22:00 -0700', :location => 'here' })
    event2 = Event.create({:start_date => (Time.now + 2.day), :end_date => '2014-09-03 12:22:00 -0700', :location => 'here' })
    events = Event.todays_events(0)
    expect(events).to eq [event3, event1]
  end

  it 'it sorts all entered events returning only those happening this week' do
    event1 = Event.create({:start_date => (Time.now + 1.month), :end_date => '2014-05-03 12:22:00 -0700', :location => 'here' })
    event3 = Event.create({:start_date => (Time.now + 10.day), :end_date => '2014-10-03 12:22:00 -0700', :location => 'here' })
    event2 = Event.create({:start_date => (Time.now + 2.day), :end_date => '2014-09-03 12:22:00 -0700', :location => 'here' })
    events = Event.week(0)
    expect(events).to eq [event2]
  end

  it 'it sorts all entered events returning only those happening this month' do
    event1 = Event.create({:start_date => (Time.now + 1.day), :end_date => '2014-05-03 12:22:00 -0700', :location => 'here' })
    event3 = Event.create({:start_date => (Time.now + 2.month), :end_date => '2014-10-03 12:22:00 -0700', :location => 'here' })
    event2 = Event.create({:start_date => (Time.now + 2.day), :end_date => '2014-09-03 12:22:00 -0700', :location => 'here' })
    events = Event.month(0)
    expect(events).to eq [event1, event2]
  end
end


