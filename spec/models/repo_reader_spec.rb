require 'spec_helper'

describe RepoReader do
  subject do
    Class.new do
      include RepoReader
      def repo
        Rugged::Repository.new(fixture_repo_path)
      end

      # TODO spec this instead shorcutting
      def lazy_read_blob(oid)
        read_blob(oid)
      end
    end.new
  end

  its(:repo_read) do
    should == [
      {:name=>"README.md", :oid=>"8aa2aed323077103c91369c23e886c6bae2d987d", :filemode=>33188, :type=>:blob, :content=>"# A README.md\n"}, 
      {:name=>"file.txt", :oid=>"82d1aa8da25e22d908c44bde9d122fea688ba3a0", :filemode=>33188, :type=>:blob, :content=>"a file.txt\n"}
    ]
  end
end
