
BUILD_DIR = "build"


task :default => :test

task :build do
  if !FileTest::exists? BUILD_DIR + "/gtest/lib/libgtest.a"
    sh "cd %s %% make deps" % BUILD_DIR
  end

  sh "cd %s && make" % BUILD_DIR
end

task :test => :build do
  sh "cd %s && make unit_test" % BUILD_DIR
end

task :bootstrap do
  FileUtils::mkdir BUILD_DIR unless FileTest::directory? BUILD_DIR
  sh "cd %s && cmake -D CMAKE_BUILD_TYPE:STRING=\"Debug\" .." % BUILD_DIR
end
