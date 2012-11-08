require 'spec_helper'

describe RepoLog do

  subject(:repo) { RepoLog.new(fixture_repo) }

  describe '#commits' do
    it {should have(2).commits}
    its(:commit_oids) {should == ["c18d3d5324e98d7bb2e5e5934e4ef6c3046a7ca1", "86709acd61353d08a1d3ff15f7fc8b554c34a378"]}
    its(:pretty_commits) {should == ["c18d3d532", "86709acd6"]}
  end

  describe '#limit' do
    subject(:repo) { RepoLog.new(fixture_repo, limit: 1) }
    its(:pretty_commits) { should == ['c18d3d532'] }
  end
end
