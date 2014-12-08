# coding: utf-8
require "fileutils"

namespace :db do
  desc "creates a new SQLite database file if it not exists"
  task :create do
    db_file = File.expand_path("../../../db/database.sqlite3", __FILE__)
    FileUtils.touch(db_file) if !File.exists?(db_file)
  end

  desc "resets the existing SQLite database"
  task :reset do
    db_file = File.expand_path("../../../db/database.sqlite3", __FILE__)
    if File.exists?(db_file)
      FileUtils.rm(db_file)
      FileUtils.touch(db_file)
    end
  end
end
