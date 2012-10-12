require 'spec_helper'

describe Gist do

  describe 'Validations' do

    context 'empty' do
      let(:gist) { Gist.new }

      it {should be_invalid}
    end

    context 'with content' do
      let(:gist) { Gist.new(:contents => []) }

      it {should be_valid}
    end

  end
end
