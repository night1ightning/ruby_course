require 'io/console'

print "Введите поочередно название товара, цену за единицу и кол-во купленного товара.\n"\
  "Ввод будет продолжатся до тех пор, пока не введет слово \"стоп\" в названия товара.\n"\
  "Будет вывод о цене на каждый товар, его количестве и итоговая сумма позиций.\n"\
  "Введите Enter, чтобы начать.\n"
STDIN.getch

positions = Hash.new
loop do
  puts ''
  print "Введите название товара: "
  name = gets.chomp
  break if name == 'stop'
  print "Введите стоимость позиции: "
  price = gets.to_f
  print "Введите количество: "
  count = gets.to_i

  totals = price * count
  positions[name] = { count: count, price: price, totals: totals }
end

print "\nИнформация о позициях: \n"
positions.each do |name, position|
  printf " Название товара: %-9s| Цена: %-5.2f | Количество: %-5i | Итого = %-5.2f\n",
    name, position[:price], position[:count], position[:totals]
end

totals_order = 0.00
positions.each do |name, position|
  totals_order += position[:totals]
end
print "\nИтоговая цена: %5.2f\n" % totals_order

