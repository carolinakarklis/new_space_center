class ErrorSerializer
  include JSONAPI::Serializer

  attribute :model do |object|
    object.class.name
  end

  attribute :errors do |object|
    object.errors.messages
  end
end