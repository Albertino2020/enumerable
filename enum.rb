# frozen_string_literal: true

#:nodoc:
# rubocop: disable Metrics/ModuleLength
module Enumerable
  *NOTHING = Object.new

  def my_each
    return to_enum :my_each unless block_given?

    0.upto(length - 1) do |index|
      yield self[index]
    end
    self
  end

  def my_each_with_index(_block = NOTHING)
    return to_enum :my_each_with_index unless block_given?

    0.upto(length - 1) do |index|
      yield self[index], index
    end
    self
  end

  def my_select
    arr = []
    return to_enum :my_select unless block_given?

    0.upto(length - 1) do |index|
      arr.push(self[index]) if yield(self[index])
    end
    arr
  end

  def my_all?(arg = NOTHING)
    temp = true
    0.upto(length - 1) do |index|
      temp &&= if block_given?
                 yield(self[index])
               elsif arg == NOTHING
                 !(self[index].nil? || self[index] == false)
               else
                 (arg === self[index])
        end
    end
    temp
  end

  # rubocop: enable Metrics/ModuleLength
  def my_any?(arg = NOTHING)
    temp = false
    0.upto(length - 1) do |index|
      temp ||= if block_given?
                 yield(self[index])
               elsif arg == NOTHING
                 !(self[index].nil? || self[index] == false)
               else
                 (arg === self[index])
        end
    end
    temp
  end

  def my_none?(pat = NOTHING)
    temp = true
    0.upto(length - 1) do |index|
      temp &&= if block_given?
                 !yield(self[index])
               elsif pat == NOTHING
                 !self[index]
               else
                 !(pat === self[index])
        end
    end
    temp
  end

  def my_count(arg = NOTHING)
    if block_given?
      my_select { |index| yield index }.length
    else
      my_select { |index| index == arg || NOTHING === arg }.length
    end
  end

  def my_map(proc = nil)
    return to_enum :my_map unless block_given?
    return my_map_proc(proc) if proc

    my_map_pb(&Proc.new)
  end

  def my_map_proc(proc)
    mapped = []
    0.upto(length - 1) do |index|
      mapped.push(proc.call(self[index]))
    end
    mapped
  end

  def my_map_pb
    mapped = []
    0.upto(length - 1) do |index|
      mapped.push(yield self[index])
    end
    mapped
  end

  # rubocop: disable, Metrics/PerceivedComplexity, Metrics/ModuleLength
  def my_inject(*args)
    input_arr = is_a?(Array) ? self : to_a
    unless input_arr.nil?
      if block_given?
        if args.size == 1
          accumulator = args[0]
        elsif args.empty?
          unless input_arr.empty?
            accumulator = input_arr[0]
            input_arr.shift
          end
        end
      elsif args.size == 2
        accumulator = args[0]
        @operator = args[1]
      elsif args.size == 1
        @operator = args[0] if args[0].is_a?(Symbol) || args[0].is_a?(String)
        unless input_arr.empty?
          accumulator = input_arr[0]
          input_arr.shift
        end
      end
    end
    0.upto(input_arr.size - 1) do |index|
      if block_given?
        accumulator = yield(accumulator, input_arr[index])
      elsif @operator.is_a?(Proc)
        accumulator = @operator.call(accumulator, input_arr[index])
      elsif !@operator.nil?
        accumulator = input_arr[index].send(@operator, accumulator)
      end
    end
    accumulator
  end
end

def multiply_els(arr = [])
  return arr.my_inject(1, :*) if Array === arr

  nil unless Array === arr
end
