# coding: utf-8
require "data_mapper"
require "yaml"

class Settings
  def self.configure_database
    db_file = File.expand_path("../../db/database.sqlite3", __FILE__)
    DataMapper.setup(:default, "sqlite3://#{db_file}")
    DataMapper.finalize.auto_upgrade!
  end

  def self.configure_test_database
    DataMapper.setup(:default, "sqlite::memory")
    DataMapper.finalize.auto_upgrade!
  end

  def self.auth_token
    config_file = load_config_file
    if !config_file.nil?
      if config_file.has_key?("auth_token") && !config_file["auth_token"].nil? && !config_file["auth_token"].empty?
        config_file["auth_token"]
      end
    end
  end

  private

  def self.load_config_file
    file = File.expand_path("../../config.yml", __FILE__)
    if File.exists?(file)
      YAML.load_file(file)
    end
  end
end
