# Search Course and Print Result Sample.
# You need by set ENV['EKISPERT_API_KEY']
#
# ---- Route 1 ----
# 10:02 PointA
#  | Line
# 10:23 PointB
#
# ---- Route 2 ----
# 10:10 PointA
#  | Line
# 10:32 PointB
#
# ---- Route 3 ----
# 10:16 PointA
#  | LineA
# 10:37 PointC
#  | LineB
# 10:37 PointB


require 'uri'

FROM = URI.encode_www_form_component("東京")
TO = URI.encode_www_form_component("高円寺")
URL = "http://api.ekispert.jp/v1/json/search/course?key=#{ENV['EKISPERT_API_KEY']}&from=#{FROM}&to=#{TO}"


# search course
require 'json'

## use 'net/http'
# require 'net/http'
# response = JSON.parse( Net::HTTP.get( URI.parse( URL) ) )

## use 'open-uri'
require 'open-uri'
response = JSON.parse(URI.open(URL).read)

# print result
response['ResultSet']['Course'].each_with_index do |course, course_index|
  puts "\n---- Route #{course_index} ----"
  if course['Route']['Line'].kind_of?(Array)
    course['Route']['Line'].each_with_index do |line, line_index|
      puts "#{line['DepartureState']['Datetime']['text'][-14..-10]} #{course['Route']['Point'][line_index]['Station']['Name']}"
      puts " | #{line['Name']}"
    end
    puts "#{course['Route']['Line'][course['Route']['Line'].length-1]['ArrivalState']['Datetime']['text'][-14..-10]} #{course['Route']['Point'][course['Route']['Point'].length-1]['Station']['Name']}"

  else
    puts "#{course['Route']['Line']['DepartureState']['Datetime']['text'][-14..-10]} #{course['Route']['Point'][0]['Station']['Name']}"
    puts " | #{course['Route']['Line']['Name']}"
    puts "#{course['Route']['Line']['ArrivalState']['Datetime']['text'][-14..-10]} #{course['Route']['Point'][1]['Station']['Name']}"
  end
end
