puts 'Event Managaer Initialized!'

require 'csv'
#require 'google/apis/civicinfo_v2'
#require 'erb'
require 'date'
#require 'pry-byebug'

def clean_zipcode(zipcode)
#  if zipcode.nil?
#    zipcode = '00000'
#  elsif zipcode.length < 5
#    zipcode = zipcode.rjust(5,'0')
#  elsif zipcode.length > 5
#    zipcode = zipcode[0..4]
#  else
#    zipcode
#  end
  zipcode.to_s.rjust(5,'0')[0..4]
end

def clean_homephone(homephone)
  homephone_numbers = homephone.gsub(/^1?\(?(\d{3})[)\-\s\.]*(\d{3})[\-\s\.]*(\d{4})$/,'\1\2\3')
  homephone_numbers = '0'*10 unless homephone_numbers.length.between?(10,11) 
  homephone_numbers.gsub(/(\d{3})(\d{3})(\d{4})/,'(\1)\2-\3')
end

def trigger_hours(csv_list)
  csv_list.rewind
  trigger_hours = csv_list.reduce(Hash.new(0)) do |result, attendee|
    hour = DateTime.strptime(attendee[:regdate],'%m/%d/%Y %H:%M').hour
    result[hour] = result[hour].to_i + 1
    result
  end
  csv_list.rewind
  trigger_hours.sort_by{|k,v| v}.reverse[0..2]
end

def trigger_weekdays(csv_list)
  csv_list.rewind
  trigger_weekdays = csv_list.reduce(Hash.new(0)) do |result, attendee|
    weekday = DateTime.strptime(attendee[:regdate],'%m/%d/%Y %H:%M').strftime("%A")    
    result[weekday] = result[weekday].to_i + 1
    result
  end
  csv_list.rewind
  trigger_weekdays.sort_by{|k,v| v}.reverse[0..2]
end
=begin
def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
  begin
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody','legislatorLowerBody']
    )
    legislators = legislators.officials.map(&:name).join (", ")
  rescue StandardError => e
    puts e
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end
def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end
=end

contents = CSV.open('event_attendees_full.csv', headers: true, header_converters: :symbol)

=begin
template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter
=end

contents.each do |row|
  #id = row[0]
  #name = row[:first_name]
  #zipcode = row[:zipcode]
  #zipcode = clean_zipcode zipcode
  #legislators = legislators_by_zipcode(zipcode)
  puts clean_homephone(row[:homephone])
  #form_letter = erb_template.result(binding)

  #save_thank_you_letter(id,form_letter)

end

puts "The trigger hours were: "
trigger_hours(contents).each do |hour|
  puts "#{hour[0]} with #{hour[1]} attendees."
end

puts "The trigger weekdays were: "
trigger_weekdays(contents).each do |weekday|
  puts "#{weekday[0]} with #{weekday[1]} attendees."
end

