# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'webmock/minitest'
require 'vcr'
require 'minitest/autorun'
require_relative 'database_cleaner_support'
require 'database_cleaner/active_record'

DatabaseCleaner.clean_with :truncation
DatabaseCleaner.strategy = :transaction

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    # fixtures :all

    # Add more helper methods to be used by all tests here...
    include DatabaseCleanerSupport
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_request do |request|
    ['127.0.0.1', 'localhost'].include?(URI(request.uri).host)
  end
end

WebMock.disallow_net_connect!(allow: ['http://127.0.0.1', 'http:localhost'])
