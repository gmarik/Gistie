require 'spec_helper'

describe Gist do

  describe 'Validations' do

    context 'blank' do
      let(:gist) { Gist.new }

      it {should be_blank}
      it {should be_invalid}
      it {should have(1).error_on(:contents) }
    end

    context 'non blank' do
      let(:gist) do
        g = Gist.new
        g.stub!(blank?: false)
        g
      end

      it { gist.should_not be_blank }
      it { gist.should be_valid }
    end

  end
end
