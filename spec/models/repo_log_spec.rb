require 'spec_helper'

describe RepoLog do

  let(:log) { RepoLog.new(fixture_repo) }
  subject   { log.to_a }

  its(:size) { should > 0 }

  describe RepoLog::Commit do

    subject { log.first }

    its(:commit_oid) { should == 'c18d3d5324e98d7bb2e5e5934e4ef6c3046a7ca1' }
    its(:pretty_sha) { should == 'c18d3d532' }
    its(:created_at) { should == Time.parse('2012-10-15 23:31:18 -0500') }

  end

  describe 'acts as enum' do
    it 'limits with take' do
      log.take(1).map(&:pretty_sha).
        should == ['c18d3d532']
    end
  end
end
