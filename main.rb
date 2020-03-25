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
          #puts 'no block here'
          retValue=true
          length.times do
            return false unless self[i]
            i += 1
          end
          return retValue
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

end


# test control
puts 'my each'
array_ctl = [9, 3, 5, 8, 1]
array_ctl.my_each { |i| puts i }
puts 'my each with index'
array_ctl.my_each_with_index { |item, i| puts item.to_s + ' ' + i.to_s }
array_str = %w[hola 3244 adios valida 344 _er tambien]

puts 'select'
puts array_str.my_select { |i| i =~ /^[a-zA-Z]*$/ }
puts ['2', 3, '4', 'hola', 'ver', 6, 8].my_select { |i| i =~ /[0-9]+/ }

puts 'myall'
puts array_str.my_all? { |i| i =~ /^[a-zA-Z]*$/ }
array_str2 = %w[hola adios valida]
puts array_str2.my_all? { |i| i =~ /^[a-zA-Z]*$/ }

puts 'myall no block'
puts array_str.my_all?
array_str3 = ['hola', 'adios', false, 'valida']
puts array_str3.my_all?

puts 'myany'
puts array_str.my_any? { |i| i =~ /^[0-9]+$/ }
array_str2 = %w[hola adios valida]
puts array_str2.my_any? { |i| i =~ /^[0-9]+$/ }
puts 'myany no block'
puts array_str.my_any?
array_str4 = [false, nil, 'hola', 'adios', 'valida']
puts array_str4.my_any?
