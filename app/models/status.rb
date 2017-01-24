class Status < ApplicationRecord

  def self.import_csv csv_file
    text = File.read(csv_file.path).gsub(/\\"/,'""')
    csv = CSV.parse(text)
    data = []
    csv.each do |l|
      oid = l[0]
      type = l[1]
      ts = DateTime.strptime(l[2],'%s')
      json_data = ActiveSupport::JSON.decode l[3]

      data.push({object_id: oid, object_type: type, timestamp: ts, state: json_data})

      # stat = Status.new(object_id: l[0], object_type: l[1],
                        # timestamp: DateTime.strptime(l[2],'%s'), json: l[3])
    end

    puts " >>> #{data}"

    Status.transaction do
      columns = [:object_id, :object_type, :timestamp, :state]
      Status.import columns, data, validate: false
    end

  end

end
