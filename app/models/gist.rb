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

  def repo
    @repo ||= begin
      path = Rails.root + 'repos/' + (self.id.to_s + ".git")
      # p path.to_s
      FileUtils.mkdir_p(path)
      Rugged::Repository.init_at(path.to_s, true)
    end
  end
end
