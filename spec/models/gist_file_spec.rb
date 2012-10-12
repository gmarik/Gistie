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


  describe ".from_params" do

    subject(:gist_file) do
      GistFile.from_params({contents: "Holla", name: "name.md"})
    end

    it { should be_valid }

    it "sets name" do
      gist_file.name.should == "name.md"
    end

    it "sets contents" do
      gist_file.contents.should == "Holla"
    end
  end

end
