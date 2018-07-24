require 'io/console'

def area_triangle(a, h)
  0.5 * a.to_f * h.to_f
end

puts "Программа подсчета"\
  " площади треугольника попросит вас ввести основание и высоту.\n"\
  "Введите Enter, чтобы начать.\n"
STDIN.getch

print '  Основание - '
a = gets.chomp
print '  Высота - '
h = gets.chomp

puts area_triangle(a, h)

