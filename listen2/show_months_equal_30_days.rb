require 'date'
require 'io/console'

print "Вывод месяцев включающих ровно 30 дней.\n\n"

def days_in_month(year, month)
  Date.new(year, month, -1).day
end

current_year = Date.today.year
days = Array.new(12) { |index| days_in_month(current_year, index + 1) }
months = [Date::MONTHNAMES.compact, days].transpose.to_h

puts 'Месяцы в этом году:'
months.each do |month, days| 
  puts " #{month} = #{days}"
end

months_30_days = months.select { |month, days| days == 30 }
print "\nУдовлетворяют условию: \n"
puts " #{months_30_days.keys.to_a.join(',')}."

