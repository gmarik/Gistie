require 'integration_spec_helper'

describe GistsController do

  let(:gist_blobs_attrs) {
    {name: 'file.txt', blob: Time.now.to_s}
  }

  let(:gist) {
    Gist.new(gist_blobs_attributes: [gist_blobs_attrs])
  }

  let(:name_input) { 'gist[gist_blobs_attributes][][name]' }
  let(:blob_input) { 'gist[gist_blobs_attributes][][blob]' }

  def create_gist
    gist.save_and_commit!
  end



  describe '.show' do
    it "works" do

      g = create_gist

      visit gist_path(g)
      page.should have_selector("h1", :text => gist_blobs_attrs[:name])
      page.should have_selector("pre", :text => gist_blobs_attrs[:blob])
    end
  end

  describe '.new' do
    it "shows Gist form" do
      visit new_gist_path
      page.should have_selector("input[name='#{name_input}']")
      page.should have_selector("textarea[name='#{blob_input}']")
    end
  end

  def fill_gist(name = 'name.md', blob = '#Hello world')
    page.fill_in(name_input, with: name)
    page.fill_in(blob_input, with: blob)
  end

  describe '.create' do
    before :each do
      visit new_gist_path
      fill_gist
      page.click_button('Create Gist')
    end

    it 'creates gist' do
      page.should have_content('Gist was successfully created')
      page.should have_content('#Hello world')
      page.should have_content('name.md')
    end
  end

end
