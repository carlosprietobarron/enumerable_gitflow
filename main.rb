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