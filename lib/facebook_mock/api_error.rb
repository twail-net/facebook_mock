# frozen_string_literal: true

module FacebookMock
  class ApiError < RuntimeError
    def initialize(hash)
      super(hash[:message])
      @hash = hash
    end

    attr_reader :hash

    def to_json
      { error: hash }.to_json
    end

    def self.not_found(id)
      ApiError.new(
        message: "Unsupported get request. Object with ID '#{id}' does not exist, cannot be loaded due to missing " \
          " permissions, or does not support this operation. Please read the Graph API documentation at " \
          "https://developers.facebook.com/docs/graph-api",
        type: "GraphMethodException",
        code: 100,
        error_subcode: 33,
      )
    end

    def self.alias_not_found(aliasid)
      ApiError.new(
        message: "(#803) Some of the aliases you requested do not exist: #{aliasid}",
        type: "OAuthException",
        code: 803,
      )
    end
  end
end
