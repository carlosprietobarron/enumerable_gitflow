# rubocop:disable Metrics/MethodLength,Metrics/ModuleLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity

module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    length.times do
      yield (self[i])
      i += 1
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    length.times do
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    arr_ret = []
    i = 0
    length.times do
      arr_ret.push(self[i]) if yield(self[i])
      i += 1
    end
    arr_ret
  end

  def my_all?(par = nil)
    ret_value = true

    if block_given?
      i = 0
      length.times do
        return false unless yield(self[i])

        i += 1
      end
    elsif !par
      i = 0
      length.times do
        return false unless self[i]

        i += 1
      end
    else
      if par.is_a? Regexp
        my_each { |x| ret_value = false unless x =~ par }
        return ret_value
      end
      if par.is_a? Class
        my_each { |x| ret_value = false unless x.is_a?(par) }
        return ret_value
      end
      unless par.nil?
        my_each { |x| ret_value = false unless x == par }
      end
    end
    ret_value
  end

  def my_any?(par = nil)
    ret_value = false
    if block_given?
      i = 0
      length.times do
        return true if yield(self[i])

        i += 1
      end
    elsif !par
      i = 0
      length.times do
        return true if self[i]

        i += 1
      end
    else
      if par.is_a? Regexp
        my_each { |x| ret_value = true if x =~ par }
        return ret_value
      end
      if par.is_a? Class
        my_each { |x| ret_value = true if x.is_a?(par) }
        return ret_value
      end
      unless par.nil?
        my_each { |x| ret_value = true if x == par }
      end
    end
    ret_value
  end

  def my_none?(par = nil)
    ret_value = true
    if block_given?
      i = 0
      length.times do
        return false if yield(self[i])

        i += 1
      end
    elsif !par
      i = 0
      length.times do
        return false if self[i]

        i += 1
      end
    else
      if par.is_a? Regexp
        my_each { |x| ret_value = false if x =~ par }
        return ret_value
      end
      if par.is_a? Class
        my_each { |x| ret_value = false if x.is_a?(par) }
        return ret_value
      end
      unless par.nil?
        my_each { |x| ret_value = false if x == par }
      end
    end
    ret_value
  end

  def my_count(par = nil)
    counter = 0
    if block_given?
      i = 0
      length.times do
        counter += 1 if yield(self[i])
        i += 1
      end
    elsif !par
      return length
    else
      if par.is_a? Regexp
        my_each { |x| counter += 1 if x =~ par }
        return counter
      end
      if par.is_a? Class
        my_each { |x| counter += 1 if x.is_a?(par) }
        return counter
      end
      unless par.nil?
        my_each { |x| counter += 1 if x == par }
      end
    end
    counter
  end

  def my_map_old
    return to_enum unless block_given?

    arr_ret = []
    i = 0
    length.times do
      arr_ret.push(yield(self[i]))
      i += 1
    end
    arr_ret
  end

  def my_map(proces = nil)
    i = 0
    arr = []
    unless proces.nil?
      return to_enum unless proces.is_a?(Proc)
      p "proceas el proc"
      length.times do
        arr << proces.call(self[i])
        i += 1
      end
      return arr
    end
    if block_given?
      i = 0
      length.times do
        arr.push(yield(self[i]))
        i += 1
      end
      arr
    else
      to_enum
    end
  end

  def my_inject(arg1 = nil, arg2 = nil)
    a = self
    a = Array(self) if is_a? Range
    op = ['+', '-', '*', '/', '%', '**'].freeze
    i=0
    total=nil
    loops=a.length
    symb = arg2.to_sym if op.include?(arg2.to_s)
    total = arg1 if arg1.is_a? Numeric
    symb = arg1.to_sym if op.include?(arg1.to_s)
    unless symb.nil?
      i=1 if total.nil?
      loops-=i 
      total=first if total.nil?
      loops.times do
        total = total.send(symb, a[i]) if i < a.length
        i += 1
      end
      return total
    end
    if block_given?
      i=1 if total.nil?
      loops-=i 
      total=first if total.nil?
      loops.times do
        total = yield(total, a[i]) if i < a.length
        i += 1
      end
      return total
    end
  end

end

def multiply_els(arr = [])
  block = proc { |i, n| i * n }
  return arr.my_inject(&block)
end

# rubocop:enable Metrics/MethodLength,Metrics/ModuleLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
