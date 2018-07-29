require 'io/console'

def number_day_of_year(year, month, day)
  year_months = [30, days_february(year), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  full_month_days(year_months, month) + day
end

def full_month_days(year_months, month)
  last_full_month = month - 2
  return 0 if last_full_month < 0
  year_months[0..last_full_month].reduce(:+)
end

def leap_year?(year)
  return true if (year % 400).zero?
  if (year % 4).zero? 
    return true unless (year % 100).zero?
  end
  false
end

def days_february(year)
  leap_year?(year) ? 29 : 28
end

print "Программа попросит три числа, которые обозначают число, месяц, год.\n"\
  "Найдет порядковый номер даты, начиная отсчет с начала года.\n"\
  "Введите Enter, чтобы начать.\n\n"
STDIN.getch

set_number_by = lambda do |name| 
  print "Введите #{name}: "
  gets.to_i
end

year = set_number_by.call('Год')
month = set_number_by.call('Месяц')
day = set_number_by.call('Число')

number = number_day_of_year(year, month, day)
print "\nНомер дня в году: #{number}\n"

