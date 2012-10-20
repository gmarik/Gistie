require 'spec_helper'

describe GistRepo do

  def r(*args)
    GistRepo.new(*args)
  end

  subject { r(fixture_repo_path) }

  describe '.new' do
    it 'accepts path' do
      r(fixture_repo_path).path.
        should == fixture_repo_path
    end
  end

  its(:path) { should == fixture_repo_path }
  its(:repo) { should be_a(Rugged::Repository) }

  it { should be_a(RepoReader) }
  it { should be_a(RepoWriter) }
end
