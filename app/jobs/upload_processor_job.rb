class UploadProcessorJob < ApplicationJob
  queue_as :default

  def perform(file)
    Status.import_csv file
  end
end
