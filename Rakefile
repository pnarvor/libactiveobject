
task :default => "hunter:build"

@conan_opts = {}
@conan_settings = {}
@conan_scopes = { build_tests: 'True' }
load 'config.rb' if FileTest.readable? 'config.rb'

build_root = ENV['BUILD_ROOT'] || "build"

['Debug','Release'].each { |build_type|
  namespace build_type.downcase.to_sym do
    build_dir = ENV['BUILD_DIR'] || "#{build_root}-#{build_type}"

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

namespace :hunter do
  task :build do
    sh "cmake -H. -B_builds -DHUNTER_STATUS_DEBUG=ON -DCMAKE_BUILD_TYPE=Release"
    sh "cmake --build _builds --config Release"
  end

  task :test do
    sh "cmake -H. -B_builds -DHUNTER_STATUS_DEBUG=ON -DBUILD_UNIT_TESTS=ON -DCMAKE_BUILD_TYPE=Release"
    sh "cmake --build _builds --config Release"

    sh "cd _builds && make unit_test"
  end
end


task :distclean do
  sh "rm -rf _builds"
end

namespace :dependencies do
  task :trusty do
    sh "sudo apt-get install -y cmake"
  end

  task :osx do
    sh "brew update"
  end

end
