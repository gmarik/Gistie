require 'spec_helper'

describe Gist do

  describe 'Validations' do

    context 'blank' do
      subject(:gist) { Gist.new }

      it {should be_blank}
      it {should be_invalid}
      it {should have(1).error_on(:contents) }
    end

    context 'non blank' do
      subject(:gist) do
        g = Gist.new
        g.stub!(blank?: false)
        g
      end

      it { should_not be_blank }
      it { should be_valid }
    end

  end

  describe 'Gist Files' do

    subject(:gist) do
      Gist.new(gist_files_attributes: [{contents: "Holla"}])
    end

    it { should be_valid }
    it { should have(1).gist_file }
  end
end
