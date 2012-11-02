require 'integration_spec_helper'

describe GistsController do

  let(:blob_attrs) { {name: 'file.txt', blob: 'something'} }
  let(:gist) { Gist.new(gist_blobs_attributes: [blob_attrs]) }

  let(:name_input) { 'gist[gist_blobs_attributes][][name]' }
  let(:blob_input) { 'gist[gist_blobs_attributes][][blob]' }

  def create_gist
    g = gist.save_and_commit!; g
  end

  def fill_gist(name = 'name.md', blob = '#Hello world')
    page.fill_in(name_input, with: name)
    page.fill_in(blob_input, with: blob)
  end

  subject {page}

  describe '.index' do
    let(:created_gist) { create_gist }
    before(:each) {
      created_gist # trigger creation
      visit gists_path
    }

    it { should have_selector(".gist[data-gist_id='#{created_gist.id}']")   }
  end

  describe '.show' do
    let(:a_gist) { create_gist }
    let(:a_blob) { a_gist.gist_blobs.first }

    before(:each) { visit gist_path(a_gist) }

    it { should have_selector("div", :text => a_blob.name)   }
    xit { should have_selector("data.syntax", :text => a_blob.blob)  }
  end

  describe '.new' do
    before(:each) {  visit new_gist_path }

    it { should have_selector("input[name='#{name_input}']")    }
    it { should have_selector("textarea[name='#{blob_input}']") }
  end

  describe '.create' do
    before :each do
      visit new_gist_path
      fill_gist
      page.click_button('Create Gist')
    end

    it { should have_content('Gist was successfully created') }
    it { should have_content('#Hello world') }
    it { should have_content('name.md') }
  end


  describe '.edit' do
    let(:a_gist) { create_gist }
    let(:a_blob) { a_gist.gist_blobs.first }

    before(:each) { visit edit_gist_path(a_gist) }

    it { should have_selector("input[name*=name]",    value: a_blob.name  )    }
    it { should have_selector("textarea[name*=blob]", text: a_blob.blob) }
  end

  describe '.update' do
    context 'with invalid input' do
      xit { should have_content('validation failed') }
    end

    context 'with valid input' do
      before :each do
        gist = create_gist
        visit edit_gist_path(gist)
        fill_gist('new_name.txt', blob = 'hey')
        page.click_button('Update Gist')
      end

      it { should have_content('Gist was successfully updated') }
      it { should have_content('hey') }
      it { should have_content('new_name.txt') }
    end
  end

  describe '.destroy' do
    before :each do
      gist = create_gist
      visit gist_path(gist)

      page.click_link('Destroy')
    end

    it { should have_content('Gist was successfully deleted') }
  end

end
