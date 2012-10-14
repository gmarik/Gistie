require 'spec_helper'

describe CreateGist do
  let(:gist) do
     Gist.new(gist_blobs_attributes: [{blob: "Holla"}])
  end

  let(:create) {
    c = CreateGist.new
    c.stub(:write)
    c
  }

  let(:create_with_write) { CreateGist.new }

  it "creates Gist" do
    lambda do
      create.call(gist)
    end.should change(Gist, :count).by(1)
  end

  it "initializes repo" do
    create.call(gist)
    gist.repo.should be_a(Rugged::Repository)
  end

  it "writes to git" do
    GistWriter.
      should_receive(:new).
      and_return(writer = mock(:writer))

    writer.should_receive(:write).
      with(gist.gist_blobs)

    create_with_write.call(gist)
  end
end
