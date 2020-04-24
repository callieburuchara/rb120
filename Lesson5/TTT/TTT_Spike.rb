
def joinor(array)
  return "#{array[0]}" if array.size == 1
  return array.join(' or ') if array.size == 2
  array[0..-2].join(', ') + ', or ' + "#{array[-1]}"
end

p joinor([1, 2, 3, 4])
p joinor([1, 2])
p joinor([1])