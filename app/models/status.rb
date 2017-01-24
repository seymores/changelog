class Status < ApplicationRecord

  def self.import csv_file
    File.foreach(csv_file.path).with_index do |line, index|
      puts ">>>> " + line
    end
  end

end
