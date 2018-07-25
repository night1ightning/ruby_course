require 'io/console'

def area_triangle(base, height)
  0.5 * base * height
end

puts "Программа подсчета"\
  " площади треугольника попросит вас ввести основание и высоту.\n"\
  "Введите Enter, чтобы начать.\n"
STDIN.getch

print '  Основание : '
base = gets.to_f
print '  Высота : '
height = gets.to_f

print "\nРешение: "
print area_triangle(base, height)
puts ''

