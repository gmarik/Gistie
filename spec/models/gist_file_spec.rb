require 'spec_helper'

describe GistFile do

  describe 'Validations' do

    context "invalid" do
      subject(:gist_file) { GistFile.new }

      it {should be_invalid}
      it {should have(1).error_on(:contents) }
    end

    context "valid" do
      subject(:gist_file) {
        GistFile.new.tap do |g|
          g.contents = "Holla"
        end
      }

      it {should be_valid}
      it {should have(0).errors }
    end
  end

end
