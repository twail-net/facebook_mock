# frozen_string_literal: true

module FacebookMock
  class Database
    def initialize
      @db = {}
    end

    def find(id)
      db[id]
    end

    private

    attr_reader :db
  end
end
