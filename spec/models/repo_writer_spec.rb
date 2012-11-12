require 'spec_helper'

describe RepoWriter do

  let(:repo_writer) {
    Struct.new(:repo) do
      include RepoWriter
    end.new(temp_repo)
  }

  let(:author) {
    {
      email: "Gistie@Gistie.com",
      # important to fix the time as it causes commit SHA to change
      time: '2012.10.10 18:00:01'.to_time,
      name: "Gistie"
    }
  }

  let(:a_blob) { mock(blob: "Holla!", name: "README.txt") }

  it { repo_writer.should respond_to(:repo) }

  context 'duplicate commit' do
    let(:write) do
      -> { repo_writer.write([a_blob]) }
    end

    it "raises NothingToCommitError" do
      write.()

      -> { write.() }.
        should raise_error(RepoWriter::NothingToCommitError)
    end
  end

  describe '.write_blob' do
    it "writes blob" do
      repo_writer.write_blob("Holla!").
        should == 'cb05ffd087a6e689a3c465b8bab953d3ff60a3df'
    end
  end

  describe '.write_blobs' do
    it "writes blobs" do
      repo_writer.write_blobs([a_blob]).
        should == [['README.txt', 'cb05ffd087a6e689a3c465b8bab953d3ff60a3df']]
    end
  end

  describe '.write_tree' do
    it "writes tree repo" do
      named_sha1s = repo_writer.write_blobs([a_blob])
      repo_writer.write_tree(named_sha1s).
        should == '7edf19d1b0fcb86bdbf38292202bec299321fea3'
    end
  end

  describe '.write_commit' do
    it "writes commit" do
      named_sha1s = repo_writer.write_blobs([a_blob])
      toid = repo_writer.write_tree(named_sha1s)
      repo_writer.write_commit(toid, author).
        should == 'a5772b04cc0f61af73868f36a90e2e669c402e78'
    end
  end
end
