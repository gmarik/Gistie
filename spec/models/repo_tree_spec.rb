require 'spec_helper'


describe RepoTree do

  let(:repo) { RepoTree.new(fixture_repo, 'c18d3d5324e98d7bb2e5e5934e4ef6c3046a7ca1') }
  subject { repo }

  its(:repo) { should be_a(Rugged::Repository) }
  its(:head) { should == 'c18d3d5324e98d7bb2e5e5934e4ef6c3046a7ca1' }

  it 'has entries' do
    repo.to_a.size.should == 2
  end

  describe RepoTree::Blob do

    subject { repo.to_a.first }

    it { should be_a(RepoTree::Blob) }
    its(:name) { should == 'README.md' }
    its(:type) { should == :blob }
    its(:filemode) { should == 33188 }
    its(:oid) { should == '8aa2aed323077103c91369c23e886c6bae2d987d' }
    its(:content) { should == "# A README.md\n" }
  end



end
