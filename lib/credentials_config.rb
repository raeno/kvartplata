module CredentialsConfig
  class << self

    def config
      @@config ||= {}
    end

    def config=(hash)
      @@config = hash
    end

  end
end