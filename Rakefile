
task :default => "debug:test"


['Debug','Release'].each { |build_type|
  namespace build_type.downcase.to_sym do
    build_dir = ENV['BUILD_DIR'] || "build-#{build_type}"

    task :build do
      unless FileTest::directory? build_dir
        FileUtils::mkdir build_dir
        sh "cd %s && cmake -D CMAKE_BUILD_TYPE:STRING=\"%s\" -D BUILD_UNIT_TESTS:BOOL=True .." % [build_dir, build_type]
      end

      if !FileTest::exists? build_dir + "/gtest/lib/libgtest.a"
        sh "cd %s && make deps" % build_dir
      end

      sh "cd %s && make" % build_dir
    end

    task :test => :build do
      sh "cd %s && make unit_test" % build_dir
    end
  end
}

namespace :dependencies do
  task :linux do
    sh "sudo apt-get install -y cmake"
  end

  task :osx do
    sh "brew update"
    sh "brew install cmake"
  end
end
