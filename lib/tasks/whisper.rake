# frozen_string_literal: true

# all tasks concerning whispercpp
#
require "fileutils"
namespace :whisper do
  desc "Initialize Submodule of whisper.cpp"
  task :setup do
    sh "git submodule update --init vendor/whisper.cpp"
    FileUtils.cd "vendor/whisper.cpp"
    begin
      FileUtils.mkdir "build"
    rescue
    end
    FileUtils.cd "build"
    sh "cmake ../"
    sh "make"
    FileUtils.cd Rails.root.to_s
    puts "Due the complexity of configuration options of whisper.cpp"
    puts "you should consult https://github.com/ggml-org/whisper.cpp or"
    puts "vendor/whisper.cpp/README.md and build a version which fits "
    puts "your hardware needs and requirements"
  end
  desc "Get model for whisper.cpp - use it this way MODEL=<modelname>"
  task :get_model do
    FileUtils.cd "vendor/whisper.cpp/models"
    sh "./download-ggml-model.sh #{ENV['MODEL']}"
  end
  desc "Show available models"
  task :show_models do
    FileUtils.cd "vendor/whisper.cpp/models"
    sh "./download-ggml-model.sh"
  end
end
