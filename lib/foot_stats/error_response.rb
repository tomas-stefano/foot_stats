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
  end
end