require "bundler/gem_tasks"
require "jasmine"
require "rspec/core/rake_task"
require "opal"

load "jasmine/tasks/jasmine.rake"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec # task :default => [:spec, :"javascript:spec"]

namespace :javascript do
  desc "Build javascript using opal"
  task :build do
    Opal.append_path "lib"
    File.binwrite "build/mighty_maps.js", Opal::Builder.build("opal_bootstrap").to_s
  end

  desc "Run jasmin specs"
  task :spec => [:"javascript:build", :"jasmine:ci"]
end

