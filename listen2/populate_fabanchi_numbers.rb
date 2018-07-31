print "Программа выводит числа Фабиначи до 100.\n\n"

numbers = [0, 1, 1]
element = 2
while element <= 100 
  numbers << element 
  element = numbers[-1] + numbers[-2]
end
puts 'Числа:'
puts " #{numbers.join(',')}."

