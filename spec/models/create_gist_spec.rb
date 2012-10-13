require 'spec_helper'

describe CreateGist do
  let(:gist) do
     Gist.new(gist_files_attributes: [{contents: "Holla"}])
  end

  after :each do
    `mv #{gist.repo.path} /tmp`
  end

  it "creates Gist" do
    lambda do
      CreateGist.new.call(gist)
    end.should change(Gist, :count).by(1)
  end

  it "initializes repo" do
    CreateGist.new.call(gist)
    gist.repo.should be_a(Rugged::Repository)
  end

  xit "commits content" do

  end

end
