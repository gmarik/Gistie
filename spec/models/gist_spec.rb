require 'spec_helper'

describe Gist do

  describe 'Validations' do

    context 'blank' do
      subject(:blank_gist) { Gist.new }

      it {should be_blank}
      it {should be_invalid}
      it {should have(1).error_on(:gist_blobs) }
    end

    context 'non blank' do
      subject(:gist) do
        Gist.new(gist_blobs_attributes: [{blob: "holla!"}])
      end

      it { should_not be_blank }
      it { should be_valid }
    end

    describe 'uniq names' do
      subject(:gist) do
        gist_blobs = [{ blob: '1', name: '1'}, { blob: '2', name: '1'}]
        g = Gist.new(gist_blobs_attributes: gist_blobs)
      end

      it { should have(1).errors_on(:gist_blobs) }
    end

    describe 'blank blobs' do
      subject(:gist) do
        gist_blobs = [{ blob: '', name: '1'}, { blob: '', name: '1'}]
        g = Gist.new(gist_blobs_attributes: gist_blobs)
      end

      it { should have(1).errors_on(:gist_blobs) }
      it { should be_blank }
    end

  end

  describe '.gist_blobs' do
    context 'existing Gist' do
      let(:gist_blob) {
        {name: 'file', content: 'holla!', blob: 'holla!'}
      }

      let(:fake_repo) {
        mock(:Repo, repo_read: [{name: 'file', content: 'holla!'}])
      }

      subject(:gist) do
        g = Gist.new()
        g.stub!(new_record?: false )
        g.stub!(repo: fake_repo )
        g
      end

      it 'reads repo content' do
        gist.gist_blobs == [gist_blob]
      end

    end

    context 'new Gist with blob_attributes set' do
      subject(:gist) do
        Gist.new(gist_blobs_attributes: [{blob: "Holla"}])
      end

      it { should be_valid }
      it { should have(1).gist_blobs }
    end

    context 'new Gist' do
      subject(:gist) { Gist.new }

      it { should be_invalid }
      it { should have(0).gist_blobs }
    end

  end

  describe '.create' do
    it 'creates gist' do
      lambda do
        Gist.create!(gist_blobs_attributes: [{blob: "Holla"}])
      end.should change(Gist, :count).by(1)
    end
  end
end
