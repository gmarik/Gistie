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

  context "create" do

    let(:create) {
      save_no_write 
    }

    it "creates Gist" do
      create.should change(Gist, :count).by(1)
    end

    it "initializes repo" do
      create.should change(gist, :repo).from(nil)

      gist.repo.should be_a(GistRepo)
    end
  end

  context "update" do

    let(:update) {
      gist.stub!(new_record?: false)
      save_no_write
    }

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



  # This exception is to prevent empty commits
  # so when Gist decription gets updated it has to be ignored
  context "NothingToCommit" do

    let(:gist) {
      mock(:gist,
           assign_attributes: true,
           new_record?: true,
           save!: true,
           init_repo: true,
          )
    }


    let(:update) {
      gist.should_receive(:transaction).and_yield
      gist.should_receive(:gist_write).and_raise(RepoWriter::NothingToCommitError)
      SaveGist.new(gist)
    }

    it "ignores exception" do
      -> { update.() }.should_not raise_error
    end
  end
end
