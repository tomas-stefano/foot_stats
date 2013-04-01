module FootStats
  class ErrorResponse
    include Enumerable
    attr_reader :message

    def initialize(message)
      @message = message
    end

    # Compare to other Error response getting the exactly same message.
    #
    # @return [True, False]
    #
    def ==(other)
      @message == other.message
    end

    # The each method is here because it's useful <b>when getting the FootStats Info via polling</b>.
    #
    # @example
    #
    #     championships = Championship.all
    #     # => <# ErrorResponse message='500 Internal Server Error'>
    #
    #     # When Error Response will not call #each and won't create anything.
    #     championships.each { |championship| Championship.create(name: championship.name) }
    #     # => []
    #
    # @return [True, False]
    #
    def each(&block)
      []
    end
    # This methods should return an empty collection for DSL purpose when Live returns Error.
    alias :players :each
    alias :goals :each
    alias :cards :each

    # <b>Respect the contract with the Resource Instance and Resource Collections.</b>
    # This method is useful when you want to store the response in your database or
    # log this in your own way.
    #
    # <b>I prefer to explicit this and explain, instead use the alias keyword in Ruby.</b>
    #
    def response
      message
    end
  end
end