require 'spec_helper'

describe SimpleUtilCollection::BooleanUtil do
  describe '.loosely_true?' do
    context "when the input is loosely true" do
      it 'returns true' do
        expect(SimpleUtilCollection::BooleanUtil.loosely_true?( '1' )).to be_true
        expect(SimpleUtilCollection::BooleanUtil.loosely_true?( 't' )).to be_true
        expect(SimpleUtilCollection::BooleanUtil.loosely_true?( 'true' )).to be_true
        expect(SimpleUtilCollection::BooleanUtil.loosely_true?( true )).to be_true
        expect(SimpleUtilCollection::BooleanUtil.loosely_true?( 'yes' )).to be_true
        expect(SimpleUtilCollection::BooleanUtil.loosely_true?( 'y' )).to be_true
        expect(SimpleUtilCollection::BooleanUtil.loosely_true?( 'TRUE' )).to be_true
      end
    end

    context "when the input is loosely false" do
      it 'returns false' do
        expect(SimpleUtilCollection::BooleanUtil.loosely_true?( '0' )).to be_false
        expect(SimpleUtilCollection::BooleanUtil.loosely_true?( 'f' )).to be_false
        expect(SimpleUtilCollection::BooleanUtil.loosely_true?( 'false' )).to be_false
        expect(SimpleUtilCollection::BooleanUtil.loosely_true?( false )).to be_false
        expect(SimpleUtilCollection::BooleanUtil.loosely_true?( 'no' )).to be_false
        expect(SimpleUtilCollection::BooleanUtil.loosely_true?( 'n' )).to be_false
        expect(SimpleUtilCollection::BooleanUtil.loosely_true?( 'FALSE' )).to be_false
        expect(SimpleUtilCollection::BooleanUtil.loosely_true?( '' )).to be_false 
        expect(SimpleUtilCollection::BooleanUtil.loosely_true?( nil )).to be_false        
      end
    end    
  end
end
