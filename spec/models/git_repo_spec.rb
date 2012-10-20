require 'spec_helper'

describe GistRepo do

  def r(*args)
    GistRepo.new(*args)
  end

  describe '.new' do
    it 'accepts path' do
      r('path').path.should == 'path'
    end
  end

  describe '.repo' do
    subject { GistRepo.new(fixture_repo_path.to_s) }
    its(:repo) { should be_a(Rugged::Repository) }
  end

  xit { r('path').should be_a(GistRepoReader) }
  xit { r('path').should be_a(GistRepoWriter) }

end
