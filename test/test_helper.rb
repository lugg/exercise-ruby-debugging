ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/minitest'

require_dependency Rails.root.join('test/support/fake_onfleet')

WebMock.disable_net_connect!(allow: 'maps.googleapis.com')

class ActiveSupport::TestCase
  fixtures :all

  def setup
    WebMock.stub_request(:any, /onfleet.com/).to_rack(FakeOnfleet)
  end
end
