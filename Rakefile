
task :default => "debug:test"

@build_opts = {}
load 'config.rb' if FileTest.readable? 'config.rb'

['Debug','Release'].each { |build_type|
  namespace build_type.downcase.to_sym do
    build_dir = ENV['BUILD_DIR'] || "build-#{build_type}"

    task :build do
      FileUtils::mkdir build_dir unless FileTest::directory? build_dir
      sh "cd %s && conan install --scope build_tests=True -s build_type=%s .. --build=missing" % [build_dir, build_type]
      sh "cd %s && conan build .." % [build_dir]
    end

    task :test => :build do
      sh "cd %s && make unit_test" % build_dir
    end
  end
}

namespace :conan  do
  desc "Export as Conan package"
  task :export => :distclean do
    sh "conan export amarburg/testing"
  end
end

task :distclean do
  sh "rm -rf build-*"
end

namespace :dependencies do
  task :linux do
    sh "sudo apt-get install -y cmake libboost-system-dev libboost-filesystem-dev libboost-thread-dev"
    sh "pip install conan"
  end

  task :osx do
    sh "brew update"
    sh "brew install cmake conan"
  end
end
