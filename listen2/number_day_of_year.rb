require 'io/console'

def number_day_of_year(year, month, day)
  year_months = [30, days_february(year), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  year_months[0...month - 1].reduce(day, :+)
end


def leap_year?(year)
  (year % 400).zero? || (year % 4).zero? && (year % 100).nonzero?
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

