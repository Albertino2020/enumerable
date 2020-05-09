# frozen_string_literal: true

#:nodoc:
module Enumerable
  # *********************************
  # Beginning of my_each method.
  # *********************************
  def my_each
    to_enum :my_each unless block_given?
    0.upto(length - 1) do |index|
      yield self[index]
    end
  end

  # *********************************
  # End of my_each method.
  # *********************************

  # *********************************
  # Beginning of my_each_with_index method.
  # *********************************
  def my_each_with_index
    to_enum :my_each_with_index unless block_given?
    0.upto(length - 1) do |index|
      yield self[index], index
    end
  end

  # *********************************
  # End of my_each_with_index method.
  # *********************************

  # *********************************
  # Beginning of my_select method.
  # *********************************
  def my_select
    arr = []
    to_enum :my_select unless block_given?
    0.upto(length - 1) do |index|
      arr.push(self[index]) if yield(self[index])
    end
    arr
  end

  # *********************************
  # End of my_select method.
  # *********************************
  # *********************************
  # Beginning of my_all method.
  # *********************************
  def my_all
    temp = true
    nil unless block_given?
    0.upto(length - 1) do |index|
      temp &&= yield(self[index])
    end
    temp
  end

  # *********************************
  # End of my_all method.
  # *********************************
  # *********************************
  # Beginning of my_any method.
  # *********************************
  def my_any
    temp = false
    0.upto(length - 1) do |index|
      temp ||= yield(self[index])
    end
    temp
  end

  # *********************************
  # End of my_any method.
  # *********************************
end

# *********************************
# RUNNING TESTS BELOW
# *********************************
# *********************************
# Running my_each method test.
# *********************************
arr = []
[1, 2, 3, 4, 5].my_each { |num| arr.push(num * 2) }
print arr

# ***************************************
# Running my_each_with_index method test.
# ***************************************
hash = {}
%w[cat dog wombat].my_each_with_index do |item, index|
  hash[item] = index
end
print hash
# *********************************
# Running my_select method test.
# *********************************
print [1, 2, 3, 4, 5].my_select(&:even?)
# *********************************
# Running my_all method test.
# *********************************
print([1, 2, 3, 4, 5].my_all { |num| num < 3 })
print([1, 2, 3, 4, 5].my_all { |num| num < 10 })
# *********************************
# Running my_any method test.
# *********************************
print([1, 2, 3, 4, 5].my_any { |num| num < 1 })
print([1, 2, 3, 4, 5].my_any { |num| num > 10 })
print([].my_any { |num| num < 1 })
print([1, 2, 3, 4, 5].my_any { |num| num < 10 })
