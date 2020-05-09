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
end

# *********************************
# RUNNING TESTS BELOW
# *********************************
# *********************************
# Running my_each method test.
# *********************************
print([1, 2, 3, 4, 5].my_each { |num| puts num * 2 })

# ***************************************
# Running my_each_with_index method test.
# ***************************************
hash = {}
%w[cat dog wombat].my_each_with_index do |item, index|
  hash[item] = index
end
print hash
