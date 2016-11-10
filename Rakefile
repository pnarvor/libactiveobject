
task :default => "debug:test"

@conan_opts = {}
@conan_settings = {}
@conan_scopes = { build_tests: 'True' }
load 'config.rb' if FileTest.readable? 'config.rb'

['Debug','Release'].each { |build_type|
  namespace build_type.downcase.to_sym do
    build_dir = ENV['BUILD_DIR'] || "build-#{build_type}"

    @conan_settings[:build_type] = build_type
    conan_opts = @conan_opts.each_pair.map { |key,val| "-o %s=%s" % [key,val] } +
                @conan_settings.each_pair.map { |key,val| "-s %s=%s" % [key,val] } +
                @conan_scopes.each_pair.map { |key,val| "--scope %s=%s" % [key,val] }

    task :build do
      FileUtils::mkdir build_dir unless FileTest::directory? build_dir
      chdir build_dir do
      sh "conan install %s .. --build=missing" % [conan_opts.join(' ')]
      sh "conan build .."
      end
    end

    task :test => :build do
      chdir build_dir do
        sh "make unit_test"
      end
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
    sh "brew update"
    sh "brew upgrade cmake"
    sh "brew install conan"
  end

  namespace :travis do
    task :linux => "dependencies:trusty"
    task :osx => "dependencies:osx" do
      ## Technically the compiler version should be taken from Travis.yml is known
      File.open("config.rb",'w') { |f|
        f.write <<CONAN_CONF_END
@conan_settings[:compiler] = 'apple-clang'
CONAN_CONF_END
        }
      end
    end

end
