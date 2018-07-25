require 'io/console'

def right_triangle?(hypotenuse, catheter1, catheter2)
  hypotenuse**2 == catheter1**2  + catheter2**2
end

puts "Программа определит, является ли треугольник прямоугольным.\n"\
  "Если таким является проверяет, является ли он равнобедренным.\n"\
  "Если все 3 стороны равны, то треугольник равносторонний, но не прямоугольный.\n"\
  "Для этого запросит 3 eго стороны.\n"\
  "Введите Enter, чтобы начать.\n"
STDIN.getch

line_length = lambda do |name_line| 
  print " Введите длинну стороны #{name_line}: "
  gets.to_i
end
a = line_length.call('a')
b = line_length.call('b')
c = line_length.call('c')

puts "\nРешение: "

lines = [a,b,c].sort
count_not_equal_line = lines.uniq.count
if count_not_equal_line == 1
  puts " Треугольник равнобедренный и равносторонний,"\
    "но не прямоугольный."
  abort
end

response = ''
if count_not_equal_line == 2 
  response << " Треугольник равнобедренный.\n"
end
if right_triangle?(lines[2], lines[1], lines[0])
  response << " Треугольник является прямоугольным."
  puts respons
  abort
end

puts ' Не прямоугольный и не равносторонний'

