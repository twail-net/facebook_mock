# frozen_string_literal: true

module FacebookMock
  class Database
    def initialize
      @db = {}
      @aliases = {}
      @id = 1
    end

    def find(id)
      db[dealias(id)]
    end

    def create_fb_page(aliasid, name: nil)
      id = new_alias(aliasid)
      db[id] = {
        id: id,
        name: name || aliasid,
      }
    end

    def clear
      @aliases = {}
      @db = {}
    end

    private

    def dealias(id)
      id.match?(/^\d+$/) ? id : @aliases[id]
    end

    def new_alias(aliasid)
      raise 'Alias must not be empty' if aliasid.nil? || aliasid == ""
      raise 'Alias must not be numeric' if aliasid.match?(/^\d+$/)
      raise 'Alias already exists' unless @aliases[aliasid].nil?

      @aliases[aliasid] = new_id
    end

    def new_id
      # TOOD: this is not thread-safe
      @id += 1
    end

    attr_reader :db
  end
end
