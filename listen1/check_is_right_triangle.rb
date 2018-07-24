require 'io/console'

def right_triangle?(hypotenuse, catheter1, catheter2)
  hypotenuse**2 == catheter1**2  + catheter2**2
end

puts "Программа определит, является ли треугольник прямоугольным.\n"\
  "Если таким является проверяет, является ли он равнобедренным.\n"\
  "Для этого запросит 3 eго стороны.\n"\
  "Введите Enter, чтобы начать.\n"
STDIN.getch

line_length = lambda do |name_line| 
  print " Введите длинну стороны #{name_line}: "
  gets.chomp.to_i
end
a = line_length.call('a')
b = line_length.call('b')
c = line_length.call('c')

lines = [a,b,c].sort
if right_triangle?(lines[2], lines[1], lines[0])
  puts "\nТреугольник является прямоугольным."
  puts 'Треугольник равнобедренный.' if lines.uniq.count == 2 
end

