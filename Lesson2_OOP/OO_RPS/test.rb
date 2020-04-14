# TRANSLATE = {
#   0=> "zero", 1=> "one", 2=> "two", 3=> "three", 4=> "four", 
#   5=> "five", 6=> "six", 7=> "seven", 8=> "eight", 9=> "nine", 
#   10=> "ten", 11=> "eleven", 12=> "twelve", 13=> "thirteen", 
#   14=> "fourteen", 15=> "fifteen", 16=> "sixteen", 17=> "seventeen",
#   18=> "eighteen", 19=> "nineteen"
# }

ARR = %w(zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)

def alphabetic_number_sort(array)
  array.sort_by do |num|
    ARR[num]
  end
end


p alphabetic_number_sort((0..19).to_a)# == [
#   8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17,
#   6, 16, 10, 13, 3, 12, 2, 0
# ]


