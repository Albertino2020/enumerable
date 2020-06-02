# frozen_string_literal: true

require './enum.rb'

describe Enumerable do
  let(:arr) { [1, 2, 3, 4, 5, 6] }
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
        expect(arr.my_select { |x| x % 2 == 0 }).to eql([2, 4, 6])
      end
      it 'returns odd elements' do
        expect(arr.my_select { |x| x % 2 != 0 }).to eql([1, 3, 5])
      end
      it 'returns the array of elements whose square are less than 10' do
        expect(arr.my_select { |x| x ** 2 < 10 }).to eql([1, 2, 3])
      end
    end
  end
end
