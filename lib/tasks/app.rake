# coding: utf-8
require "fileutils"
require "securerandom"
require "yaml"

require "./lib/settings"

namespace :app do
  namespace :create do
    desc "creates a config file for the app if it not exists"
    task :config do
      config_file = File.expand_path("../../../config.yml", __FILE__)
      if !File.exists?(config_file)
        content = { "auth_token" => "" }
        File.open(config_file, "w") { |file| file.write content.to_yaml }
      end
    end

    desc "generates auth token for the app"
    task :token do
      if Settings.auth_token.nil?
        config_file = File.expand_path("../../../config.yml", __FILE__)
        content = { "auth_token" => SecureRandom.hex }
        File.open(config_file, "w") { |file| file.write content.to_yaml }
      end
    end
  end
end
