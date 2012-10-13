class Gist < ActiveRecord::Base

  attr_accessor :gist_files, :gist_files_attributes

  attr_accessible :gist_files_attributes

  validate :non_blank

  def non_blank
    blank? and errors.add(:contents, "Can't be blank")
  end

  def blank?
    gist_files.blank?
  end

  def gist_files_attributes=(attrs)
    self.gist_files = attrs.map do |attr|
      GistFile.from_params(attr)
    end
  end

  def repo_path
    path = Rails.root + 'repos/' + (self.id.to_s + ".git")
  end

  def repo
    if new_record? then nil
    else @repo ||= Rugged::Repository.new(repo_path.to_s)
    end
  end

  def init_repo(path = repo_path)
    @repo ||= Rugged::Repository.init_at(path.to_s, true)
  end
end
