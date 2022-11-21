class Array
  def my_each(&blc)
    i = 0
    while i < self.length
      blc.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&blc)
    i = 0
    results = []
    while i < self.length
      if blc.call(self[i])
        results << self[i]
      end
      i += 1
    end
    results
  end

  def my_reject(&blc)
    i = 0
    results = []
    while i < self.length
      if !blc.call(self[i])
        results << self[i]
      end
      i += 1
    end
    results
  end

  def my_any?(&blc)
    i = 0

    while i < self.length
      if blc.call(self[i])
        return true
      end
      i += 1
    end
    false
  end

  def my_all?(&blc)
    i = 0

    while i < self.length
      if !blc.call(self[i])
        return false
      end
      i += 1
    end
    true
  end

  @@results = []

  def my_flatten
    self.each do |ele|
      if ele.is_a?(Array)
        ele.my_flatten
      else
        @@results << ele
      end
    end
    @@results
  end

  def my_zip(*args)
    results = Array.new(self.length) { Array.new } # [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
    self.each_with_index do |ele1, i|
      results[i][0] = ele1
      args.each_with_index do |ele2, j|
        j += 1
        results[i][j] = ele2[i]
      end
    end
    results
  end

  def my_rotate(num = 1)
    result = self.dup
    if num >= 1
      num.times do
        first = result.shift
        result = result.push(first)
      end
    else
      num.abs.times do
        last = result.pop
        result = result.unshift(last)
      end
    end
    result
  end

  def my_join(seperator = "")
    result_str = ""
    for i in 0...(self.length - 1)
      result_str += self[i] + seperator
    end
    result_str + self[-1]
  end

  def my_reverse
    result_str = []

    self.reverse_each { |e| result_str << e }

    result_str
    # for i in (self.length - 1).downto(0)
    #   result_str << self[i]
    # end
    # result_str
  end
end

# p ["a", "b", "c"].my_reverse   #=> ["c", "b", "a"]
# p [1].my_reverse               #=> [1]

# a = ["a", "b", "c", "d"]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"

# a = ["a", "b", "c", "d"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]

# a = [4, 5, 6]
# b = [7, 8, 9]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1, 2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]
# a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]
