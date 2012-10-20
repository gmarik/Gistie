require 'spec_helper'

describe SaveGist do
  let(:gist) do
    gist_blobs = [{ blob: 'Holla'}]
    Gist.new(gist_blobs_attributes: gist_blobs)
  end

  let(:save) { SaveGist.new(gist) }

  let(:save_no_write) {
    gist.should_receive(:gist_write)
    save
  }

  let(:create) { save_no_write }

  let(:update) {
    gist.stub!(new_record?: false)
    save_no_write
  }

  context "create" do

    it "creates Gist" do
      -> { create.() }.
        should change(Gist, :count).by(1)
    end

    it "initializes repo" do
      -> { create.() }.
        should change(gist, :repo).from(nil)

      gist.repo.should be_a(GistRepo)
    end
  end

  context "update" do
    it "updates attributes" do
      blob = -> { gist.gist_blobs.first.blob }
      -> {
        update.(gist_blobs_attributes: [blob: "hi"])
      }.should change(&blob).
        from("Holla").to("hi")
    end

    it "doesn't reinitialize repo" do
      gist.should_not_receive(:init_repo)
      update.()
    end
  end

  it "returns gist" do
    save_no_write.().should be_valid
  end
end
