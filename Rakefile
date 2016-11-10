
task :default => "debug:test"

@build_opts = {}
load 'config.rb' if FileTest.readable? 'config.rb'

p @build_opts

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
  task :trusty do
    sh "sudo apt-get install -y cmake libboost-system-dev libboost-filesystem-dev libboost-thread-dev"
    sh "pip install conan"
  end

  task :osx do
    pkgs = %w(cmake conan)
    sh "brew update"
    sh "brew upgrade %s || brew install %s" % [pkgs.join(' '), pkgs.join(' ')]
  end

  namespace :travis do
    task :linux => "dependencies:trusty"
    task :osx => "dependencies:osx" do
      ## Technically the compiler version should be taken from Travis.yml is known
      File.open("config.rb",'w') { |f|
        f.write <<CONAN_CONF_END
@conan_opts[:compiler] = 'apple-clang'
#@conan_opts['compiler.version'.to_sym] = '7.3'
CONAN_CONF_END
        }
      end
    end

end
