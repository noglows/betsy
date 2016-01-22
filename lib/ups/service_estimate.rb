module Ups
  class ServiceEstimates
    attr_reader :service_code, :cost, :date

    def initialize(service_code, cost, date)
      @service_code = service_code
      @cost = cost
      @date = date
    end

    def self.get_service_estimates(estimates_hash)
      estimates = []
      estimates_hash.each do |key, value|
        estimates.push(self.new(key, value["cost"], value["date"]))
      end
      return estimates
    end
  end
end
