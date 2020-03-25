module Enumerable
  def my_each
    i = 0
    length.times do
      yield (self[i])
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    length.times do
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    if block_given?
      arr_ret = []
      i = 0
      length.times do
        arr_ret.push(self[i]) if yield(self[i])
        i += 1
      end
      arr_ret
    end
  end

  def my_all?
    if block_given?
      # arr_ret=[]
      retValue = true
      i = 0
      length.times do
        if yield(self[i])
          retValue = true
        else
          return false
        end
        i += 1
      end
      retValue
    else
      i = 0
      # puts 'no block here'
      retValue = true
      length.times do
        return false unless self[i]

        i += 1
      end
      retValue
    end
  end

  def my_any?
    if block_given?
      retValue = true
      i = 0
      length.times do
        return true if yield(self[i])

        retValue = false unless yield(self[i])
        i += 1
      end
      retValue
    else
      i = 0
      length.times do
        return true if self[i]

        retValue = false
        i += 1
      end
    end
    retValue
  end

  def my_none?
    if block_given?
      retValue = false
      i = 0
      length.times do
        return false if yield(self[i])

        retValue = true unless yield(self[i])
        i += 1
      end
      retValue
    else
      i = 0
      length.times do
        return false if self[i]

        retValue = true
        i += 1
      end
    end
    retValue
  end

  def my_count(p = nil)
    counter = 0
    i = 0
    # puts "param #{p}"
    if block_given?
      length.times do
        # puts 'block : ' + self[i].to_s + yield(self[i]).to_s
        counter += 1 if yield(self[i])
        i += 1
      end
      counter
    elsif !p.nil?
      # puts 'param ' + p.to_s
      length.times do
        # puts 'param : ' + p.to_s + self[i].to_s
        counter += 1 if self[i] == p
        i += 1
      end
      counter
    else
      counter += length
      counter
    end
  end

  def my_map
    arr_ret = []
    if block_given?
      i = 0
      length.times do
        arr_ret.push(yield(self[i]))
        # puts arr_ret.inspect
        i += 1
      end
      arr_ret
    else
      arr_ret
    end
  end

  def my_map_proc(&proces)
    i = 0
    arr = []
    unless proces.nil?
      length.times do
        arr << proces.call(self[i])
        i += 1
      end
      return arr
    end
    if block_given?
      length.times do
        arr << yield(self[i])
        i += 1
      end
      arr
    end
  end

  def my_inject
    if block_given?
      num = 0
      i = 0
      (length - 1).times do
        num = yield(self[i], self[i + 1]) if i == 0
        num = yield(num, self[i + 1]) if i > 0
        i += 1
      end
    end
    num
  end

  def multiply_els(arr = [])
    puts arr.inspect
    arr.my_inject { |i, n| i * n }
  end
end
