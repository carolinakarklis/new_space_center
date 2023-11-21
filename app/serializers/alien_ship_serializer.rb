class AlienShipSerializer
  include JSONAPI::Serializer

  attributes :abductions_number, :max_crew
end
