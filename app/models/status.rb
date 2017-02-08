class Status < ApplicationRecord
    validates :object_id, :object_type, :timestamp, :state, presence: true

    def self.import_csv(csv_file)
        text = File.read(csv_file.path).gsub(/\\"/, '""')
        csv = CSV.parse(text)
        data = []

        csv.each do |l|
            data.push(object_id: l[0], object_type: l[1],
                      timestamp: DateTime.strptime(l[2], '%s'),
                      state: ActiveSupport::JSON.decode(l[3]))
        end

        Status.transaction do
            columns = [:object_id, :object_type, :timestamp, :state]
            Status.import columns, data, validate: false
        end
    end
end
