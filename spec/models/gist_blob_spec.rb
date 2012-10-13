require 'spec_helper'

describe GistBlob do

  describe 'Validations' do

    context "invalid" do
      subject(:gist_file) { GistBlob.new }

      it {should be_invalid}
      it {should have(1).error_on(:blob) }
    end

    context "valid" do
      subject(:gist_file) {
        GistBlob.new.tap do |g|
          g.blob = "Holla"
        end
      }

      it {should be_valid}
      it {should have(0).errors }
    end
  end


  describe ".from_params" do

    subject(:gist_file) do
      GistBlob.from_params({blob: "Holla", name: "name.md"})
    end

    it { should be_valid }

    it "sets name" do
      gist_file.name.should == "name.md"
    end

    it "sets blob" do
      gist_file.blob.should == "Holla"
    end
  end

end
