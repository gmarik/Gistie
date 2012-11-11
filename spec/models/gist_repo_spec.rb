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

  it { should be_a(RepoWriter) }

  describe '.named' do
    subject(:repo) { GistRepo.named('hello') }
    its(:path){ should == GistRepo.repo_path('hello') }
  end

  describe '.init_named_repo' do

    it "initializes named repository at given path" do

      Rugged::Repository.
        should_receive(:init_at).
        with(GistRepo.repo_path('a_name'), true)

      GistRepo.init_named_repo('a_name')
    end

  end

  describe '#log' do

    subject(:log) { GistRepo.new(fixture_repo_path).log }

    it { should be_a(RepoLog) }
  end
end
