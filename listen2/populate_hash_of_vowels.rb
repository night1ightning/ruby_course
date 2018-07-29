print "Программа формирует хеш из согласных,"\
"с порядоковым номером их в алфавите.\n\n"

vowels = 'аоиеёэыуюя'.split('');
alphabet = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'.split('')

numbers = vowels.map { |letter| alphabet.index(letter) + 1 }
volwels_info = [vowels, numbers].transpose.sort_by(&:last).to_h

puts "Гласная и номер в алфавите: "
volwels_info.each do |month, days| 
  puts " #{month} = #{days}"
end

