print "Программа выводит числа Фабиначи до 100.\n\n"

numbers = [0, 1, 1]
loop do
  element = numbers[-1] + numbers[-2]
  break if element > 100
  numbers << element 
end
puts 'Числа:'
puts " #{numbers.join(',')}."

