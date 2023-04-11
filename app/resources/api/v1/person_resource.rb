module Api
  module V1
    class PersonResource < JSONAPI::Resource
      attributes :first_name, :last_name, :email
    end
  end
end
