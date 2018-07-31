print "Программа формирует хеш из согласных,"\
  "с порядоковым номером их в алфавите.\n\n"

vowels = %w[а о и е ё э ы у ю я]
alphabet = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'.split('')

volwels_info = {}
alphabet.each.with_index(1) do |letter, number|
  volwels_info[letter] = number if vowels.include?(letter)
end

puts "Гласная и номер в алфавите: "
volwels_info.each do |letter, number| 
  puts " #{letter} = #{number}"
end

