print "Заполнить массив числами от 10 до 100 с шагом 5.\n\n"

numbers = (10..100).step(5).to_a

puts "Номера соответствующие итервалу: "
puts " #{numbers.join(',')}."
