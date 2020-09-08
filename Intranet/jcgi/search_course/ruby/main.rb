# Search Course and Print Result Sample.
# You need by set ENV['EKISPERT_INTRANET_URL']
# exmaple: http://example.com/expwww2/
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

FROM = URI.encode_www_form_component("東京".encode(Encoding::Shift_JIS))
TO = URI.encode_www_form_component("高円寺".encode(Encoding::Shift_JIS))
URL = "#{ENV['EKISPERT_INTRANET_URL']}expcgi.exe?val_htmb=jcgi_diadetails2&val_from=#{FROM}&val_to=#{TO}&val_hour=10&val_minute=00&val_searchtype=0"

# search course
require 'open-uri'
response = URI.open(URL).read.encode(Encoding::UTF_8)

# parse response
keyvalues = response.split('&').map do |param|
  keyvalue = param.split('=')
  keyvalue.length == 2 ? keyvalue : keyvalue.push("")
end.to_h

# print result
route_count = 1
while keyvalues.has_key?("val_route_#{route_count}") do
  puts "\n---- Route #{route_count} ----"

  line_count = 1
  while keyvalues.has_key?("val_r#{route_count}_line_from_#{line_count}") do
    time = keyvalues["val_r#{route_count}_line_dep_time_#{line_count}"].to_i
    puts "#{format("%02d", time/60)}:#{format("%02d", time%60)} #{keyvalues["val_r#{route_count}_line_from_#{line_count}"]}"
    puts " | #{keyvalues["val_r#{route_count}_line_name_#{line_count}"]}"
    line_count = line_count + 1
  end

  time = keyvalues["val_r#{route_count}_line_arr_time_#{line_count-1}"].to_i
  puts "#{format("%02d", time/60)}:#{format("%02d", time%60)} #{keyvalues["val_r#{route_count}_line_to_#{line_count-1}"]}"
  
  route_count = route_count + 1
end
