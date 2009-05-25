module Fpswax
  class PayResponse < Response
    attr_reader :transaction_id
    attr_reader :transaction_status

    def initialize(xml)
      super(xml)
      if valid?
        @transaction_id = xml.css('PayResult TransactionId')[0].content rescue nil
        @transaction_status = xml.css('PayResult TransactionStatus')[0].content rescue nil
      end
    end

    def cancelled?
      @transaction_status == 'Cancelled'
    end

    def failure?
      @transaction_status == 'Failure'
    end

    def pending?
      @transaction_status == 'Pending'
    end

    def reserved?
      @transaction_status == 'Reserved'
    end

    def success?
      @transaction_status == 'Success'
    end
  end
end
