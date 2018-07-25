require 'io/console'

def discriminant(a, b, c)
  b**2 - 4 * a * c
end

def root_x1(a, b, square_discriminant)
  (-b  + square_discriminant) / (2 * a)
end

def root_x2(a, b, square_discriminant)
  (-b  - square_discriminant) / (2 * a)
end

puts "Программа вычисляет дискриминант (D) и корни уравнения.\n"\
  "Для этого запросит 3 кожффицента.\n"\
  "Введите Enter, чтобы начать.\n"
STDIN.getch

line_length = lambda do |name_line| 
  print " Введите коэффицент #{name_line}: "
  gets.to_i
end

a = line_length.call('a')
b = line_length.call('b')
c = line_length.call('c')

puts "\nРешение:"
discriminant = discriminant(a, b, c)
puts " Дискриминант = #{discriminant}"

if discriminant < 0
  puts ' Корней нет!'
  abort
end
square_discriminant = discriminant.zero? ? 0 : Math.sqrt(discriminant)
root_x1 = root_x1(a, b, square_discriminant)
puts " Корень x1 = #{root_x1}" 
root_x2 = root_x2(a, b, square_discriminant)
puts " Корень x2 = #{root_x2}"

