require 'integration_spec_helper'

describe GistsController do
  describe '.show' do
    it "works" do
      visit '/gists/4'
      page.should have_selector("h1", :text => "name!!!!")
      page.should have_selector("pre", :text => "content!!!")
    end
  end
end
