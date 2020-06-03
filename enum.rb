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

  # rubocop: disable Metrics/MethodLength, Style/CaseEquality, Layout/EndAlignment
  def my_all?(arg = NOTHING)
    temp = true
    0.upto(length - 1) do |index|
      temp &&= (if block_given?
                 yield(self[index])
               elsif arg == NOTHING
                 !(self[index].nil? || self[index] == false)
               else
                 (arg === self[index])
        end)
    end
    temp
  end

  # rubocop: enable Metrics/MethodLength, Style/CaseEquality, Layout/EndAlignment
  # rubocop: disable Style/CaseEquality, Layout/EndAlignment, Metrics/MethodLength
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

  # rubocop: enable Style/CaseEquality, Layout/EndAlignment, Metrics/MethodLength
  # rubocop: disable Style/CaseEquality, Layout/EndAlignment, Metrics/MethodLength
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

  # rubocop: enable Style/CaseEquality, Layout/EndAlignment, Metrics/MethodLength
  # rubocop: disable Style/CaseEquality
  def my_count(arg = NOTHING)
    if block_given?
      my_select { |index| yield index }.length
    else
      my_select { |index| index == arg || NOTHING === arg }.length
    end
  end

  # rubocop: enable Style/CaseEquality
  def my_map(proc = nil)
    return to_enum :my_map unless block_given?
    return my_map_proc(proc) if proc

    my_map_pb(&Proc.new)
  end

  def my_map_proc(proc)
    mapped = []
    input_arr = is_a?(Array) ? self : to_a
    0.upto(input_arr.length - 1) do |index|
      mapped.push(proc.call(input_arr[index]))
    end

    mapped
  end

  def my_map_pb
    mapped = []
    input_arr = is_a?(Array) ? self : to_a
    0.upto(input_arr.length - 1) do |index|
      mapped.push(yield input_arr[index])
    end

    mapped
  end

  # rubocop: disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Metrics/AbcSize
  def my_inject(*args)
    input_arr = is_a?(Array) ? self : to_a
    unless input_arr.nil?
      if block_given?
        input_arr.unshift(args[0]) if args.size == 1
      elsif args.size == 2
        input_arr.unshift(args[0])
        @operator = args[1]
      elsif args.size == 1
        @operator = args[0]
      end
      accumulator = input_arr[0]
    end

    0.upto(input_arr.size - 1) do |index|
      if block_given?
        accumulator = yield(accumulator, input_arr[index]) if index.positive?
      elsif !@operator.nil?
        if args.size == 1
          if index.positive?
            accumulator = accumulator.send(@operator, input_arr[index])
          end
        else
          unless index == (input_arr.size - 1)
            accumulator = accumulator.send(@operator, input_arr[index + 1])
          end
        end
      end
    end
    accumulator
  end

  # rubocop: enable Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Metrics/ModuleLength, Metrics/AbcSize
end

# rubocop: disable Style/CaseEquality
def multiply_els(arr = NOTHING)
  return arr.my_inject(:*) if Array === arr

  nil unless Array === arr
end

# rubocop: enable Style/CaseEquality
