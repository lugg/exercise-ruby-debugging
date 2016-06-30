require "sinatra/base"

class FakeOnfleet < Sinatra::Base
  post "/api/v2/tasks" do
    # basic param validation
    %w( number street city state ).each do |attr|
      halt 400 if params[attr].blank?
    end

    content_type :json
    status 201
    MultiJson.encode(id: SecureRandom.uuid)
  end
end
