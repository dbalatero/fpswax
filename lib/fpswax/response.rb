module Fpswax
  class Response
    attr_reader :request_id, :errors
    def initialize(xml)
      # parse any errors
      @errors = xml.css('Response Errors Error').map do |error|
        code = error.css('Code')[0].content
        message = error.css('Message')[0].content
        Fpswax::Error.new(code, message)
      end

      if @errors.empty?
        @request_id = xml.css('RequestId')[0].content
      else
        @request_id = xml.css('RequestID')[0].content
      end
    end

    def valid?
      @errors.empty?
    end
  end
end
