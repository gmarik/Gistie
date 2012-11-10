require 'spec_helper'

describe GistBlob do
  subject(:gist_file) { GistBlob.new }

  describe 'Validations' do

    context "invalid" do

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

  describe "Defaults" do
    its(:name) { should == 'Text' }
  end

  describe ".new" do

    subject(:gist_file) do
      GistBlob.new({blob: "Holla", name: "name.md"})
    end

    it { should be_valid }
    its(:name) { should == "name.md" }
    its(:blob) { should == "Holla" }

  end
end
