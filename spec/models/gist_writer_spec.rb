require 'spec_helper'

describe GistWriter do

  let(:repo)   { temp_repo }
  let(:writer) { GistWriter.new(repo) }
  let(:a_blob) { mock(blob: "Holla!", name: "README.txt") }

  it "writes stuff" do
    sha1 = writer.write([a_blob])
    repo.head.target.should == sha1
  end

  describe '.write_blobs' do
    it "writes blobs to repo" do
      repo.should_receive(:write).
        with("Holla!", :blob).
        and_return('oid')

      writer.write_blobs([a_blob]).
        should == [['README.txt', 'oid']]
    end
  end

  describe '.write_tree' do
    it "writes tree repo" do
      builder = mock(:builder)
      entry = {
        type: :blob,
        name: 'README.txt',
        oid:  'oid',
        filemode: 33188
      }

      builder.should_receive(:<<).
        with(entry)
      builder.should_receive(:write).
        with(repo).
        and_return('toid')

      named_sha1 = ['README.txt', 'oid']
      writer.write_tree([named_sha1], builder).
        should == 'toid'
    end
  end

  describe '.write_commit' do
    it 'writes commit' do
      commit = mock(:commit)
      commit.should_receive(:create).
        with(repo, {
          author: 'author',
          message: "Commit\n\n",
          committer: 'author',
          parents: ['poid'],
          tree: 'toid'
        }).and_return('coid')

      writer.write_commit('toid', 'author', ['poid'], commit).should == 'coid'
    end
  end

end
