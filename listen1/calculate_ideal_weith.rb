require 'io/console'

def ideal_weight(growth)
  growth - 110
end

puts "Программа подсчета"\
  " идеального веса попросит вас ввести имя и рост.\n"\
  "Введите Enter, чтобы начать.\n"
STDIN.getch

print '  Ваше имя : '
name = gets.chomp
print '  Ваш рост : '
growth = gets.to_i

puts ''
weight = ideal_weight(growth)
if (weight > 0)
  puts "Здраствуйте \"#{name}\", ваш идеальный вес #{weight}."  
else
  puts 'Ваш вес уже оптимальный'
end

