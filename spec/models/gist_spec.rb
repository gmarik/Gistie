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

  describe '.init_repo' do
    let (:gist) {
      g = Gist.new
      g.stub!(repo_name: :a_name)
      g
    }

    it 'initializes repo' do
      GistRepo.should_receive(:init_named_repo).with(:a_name)
      gist.init_repo
    end
    
  end

  # TODO: refactor
  # - violates single responsibility
  # - tests for return values and integration with SaveGist
  describe '.save_and_commit!' do
    let (:gist) { Gist.new }

    context 'valid record' do
      subject(:gist)

      before :each do
        SaveGist.should_receive(:new).with(gist).
          and_return(save = mock(:save))

        save.should_receive(:call).
          and_return(gist)
      end

      it 'raises no error' do
        -> { gist.save_and_commit! }.should_not raise_error
      end

      its(:save_and_commit) { should be_true }
    end


    context 'invalid record' do
      subject { gist }
      it { should be_invalid }

      its(:save_and_commit) { should be_false }
      its('save_and_commit!') do
        proc { subject.save_and_commit! }.
          should raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end


  describe 'destroy_with_repo' do
    it 'destroys record'
    it 'removes repository'
  end
end
