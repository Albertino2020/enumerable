# frozen_string_literal: true

require './enum.rb'

describe Enumerable do
  let(:arr) { [1, 2, 3, 4, 5, 6] }
  let(:arr2) { [1, nil, 3, 4, 5, 6] }
  let(:arr3) { [1, 2, 3, 4, false, 6] }
  let(:arr4) { [false, false, false] }

  describe '#my_each' do
    context 'If a block is not given' do
      it 'returns enumerable' do
        expect(arr.my_each).to be_kind_of(Enumerator)
      end
    end
    context 'if a block is given' do
      it 'returns self' do
        expect(arr.my_each { |x| x**2 }).to eql(arr)
      end
    end
  end

  describe '#my_each_with_index' do
    context 'If a block is not given' do
      it 'returns enumerable' do
        expect(arr.my_each_with_index).to be_kind_of(Enumerator)
      end
    end
    context 'if a block is given' do
      it 'returns self' do
        expect(arr.my_each_with_index { |x, index| [x**2, index] }).to eql(arr)
      end
    end
  end

  describe '#my_select' do
    context 'If a block is not given' do
      it 'returns enumerable' do
        expect(arr.my_select).to be_kind_of(Enumerator)
      end
    end
    context 'if a block is given' do
      it 'returns even elements' do
        expect(arr.my_select(&:even?)).to eql([2, 4, 6])
      end
      it 'returns odd elements' do
        expect(arr.my_select(&:odd?)).to eql([1, 3, 5])
      end
      it 'returns the array of elements whose square are less than 10' do
        expect(arr.my_select { |x| x**2 < 10 }).to eql([1, 2, 3])
      end
    end
  end

  describe '#my_all?' do
    context 'if a block is given' do
      it 'returns false if all elements are divisible by 2' do
        expect(arr.my_all?(&:even?)).to eql(false)
      end
      it 'returns false if all elements are not divisible by 2' do
        expect(arr.my_all?(&:odd?)).to eql(false)
      end
      it 'returns true if all elements squared are less or equal to 36' do
        expect(arr.my_all? { |x| x**2 <= 36 }).to eql(true)
      end
      it 'returns false if the array is empty' do
        expect([].my_all?(&:odd?)).to eql(true)
      end
    end

    context 'if a block is not given' do
      it 'returns true if no element is nil or false' do
        expect(arr.my_all?).to eql(true)
      end
      it 'returns false if an element is nil or false' do
        expect(arr2.my_all?).to eql(false)
      end
      it 'returns false if an element is nil or false' do
        expect(arr3.my_all?).to eql(false)
      end
      it 'returns true' do
        expect([].my_all?).to eql(true)
      end
    end
  end

  describe '#my_any?' do
    context 'if a block is given' do
      it 'returns true if there at least one element divisible by 2' do
        expect(arr.my_any?(&:even?)).to eql(true)
      end
      it 'returns true if at least one element is not divisible by 2' do
        expect(arr.my_any?(&:odd?)).to eql(true)
      end
      it 'returns false if no element squared is greater than 36' do
        expect(arr.my_any? { |x| x**2 > 36 }).to eql(false)
      end
      it 'returns any if the array is empty' do
        expect([].my_any?(&:odd?)).to eql(false)
      end
    end

    context 'if a block is not given' do
      it 'returns true if no element is nil or false' do
        expect(arr.my_any?).to eql(true)
      end
      it 'returns true if an element is nil or false' do
        expect(arr2.my_any?).to eql(true)
      end
      it 'returns true if an element is nil or false' do
        expect(arr3.my_any?).to eql(true)
      end
      it 'returns false' do
        expect([].my_any?).to eql(false)
      end
    end
  end

  describe '#none?' do
    context 'if a block is given' do
      it 'returns false if there are even elements' do
        expect(arr.none?(&:even?)).to eql(false)
      end
      it 'returns true if none of the elements is greater than 10' do
        expect(arr.none? { |x| x > 10 }).to eql(true)
      end
      it 'returns true if an element squared is greater than 36' do
        expect(arr.none? { |x| x**2 > 36 }).to eql(true)
      end
      it 'returns true if the array is empty' do
        expect([].none?(&:odd?)).to eql(true)
      end
    end

    context 'if a block is not given' do
      it 'returns false if no element is nil or false' do
        expect(arr.none?).to eql(false)
      end
      it 'returns false if array has true elements' do
        expect(arr2.none?).to eql(false)
      end
      it 'returns true if an element is nil or false' do
        expect(arr4.none?).to eql(true)
      end
      it 'returns true when array is empty' do
        expect([].none?).to eql(true)
      end
    end
  end
end
