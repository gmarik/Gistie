ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

def temp_repo
  dir = Dir.mktmpdir 'dir'
  Rugged::Repository.init_at(dir, true)
end

def fixture_repo_path(repo_name = 'test_repo')
  Rails.root.join('spec/fixtures/').join(repo_name + '.git/').to_s
end

def fixture_repo
  Rugged::Repository.new(fixture_repo_path)
end

Cleanup = ->(spec) do
  git_repos = Rails.configuration.repo_root + '*.git/'
  Dir[git_repos].each do |dir|
    FileUtils.rm_rf(dir)
  end
end

# Set root
# Rails.configuration.repo_root = Dir.mktmpdir('test_dir')

RSpec.configure do |config|
  config.mock_with :rspec
  # TODO:
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # cleanup after
  # TODO: refactor into more granular control
  # as this is a sign of a mess
  config.after(:each, &Cleanup)

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end



