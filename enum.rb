# frozen_string_literal: true

def my_each(arr)
  0.upto(arr.length - 1) do |each|
    yield arr[each]
  end
end

my_each([1, 2, 3, 4, 5]) { |num| print num, " "}
