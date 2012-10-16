require 'spec_helper'

describe GistReader do
  let(:reader) do
    Class.new do
      include GitRepo
      include GistReader
      def repo_path; fixture_repo_path; end
      def new_record?; false; end
    end.new
  end

  it 'has access to repo' do
    reader.repo.should be_a(Rugged::Repository)
  end

  it 'reads file content and names' do
    reader.repo_read.should == [
      {:name=>"README.md", :oid=>"8aa2aed323077103c91369c23e886c6bae2d987d", :filemode=>33188, :type=>:blob, :content=>"# A README.md\n"}, 
      {:name=>"file.txt", :oid=>"82d1aa8da25e22d908c44bde9d122fea688ba3a0", :filemode=>33188, :type=>:blob, :content=>"a file.txt\n"}
    ]
  end
end
