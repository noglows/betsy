class ServiceEstimates
  attr_reader :service_name, :cost, :date

  def initialize(service_name, cost, date)
    @service_name = service_name
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
