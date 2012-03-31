class Production::InventoryStats
  class DepthReport
    attr_accessor :job_depth, :bom_depth
    # COUNTS=[:total, :customer_from_release, :customer_from_transaction, :customer_from_job, :transaction_to_same_release, :transaction_to_different_release, :transaction_to_job_to_customer, :transaction_deadend, :job_recursing, :bom_recursing, :no_transaction, :no_customer]
    COUNTS=[:total, :customer_from_release, :customer_from_bom, :no_customer]
    COUNTS.each do |key|
      attr_accessor key
    end
    attr_accessor :no_transaction_items
    def initialize(job_depth, bom_depth)
      @job_depth = job_depth
      @bom_depth = bom_depth
      COUNTS.each do |key|
        self.send "#{key}=", 0
      end
      @no_transaction_items = []
    end
    def to_s
      result = ["Job Depth = #{self.job_depth}, Bom Depth = #{self.bom_depth}"]
      COUNTS.each do |key|
        result.push "  #{key.to_s.titleize} = #{self.send(key)}"
      end
      result.push '  No transaction_items = ' + no_transaction_items.map(&:id).join(',')
      result.join("\n")
    end
    def <=>(rhs)
      [job_depth, bom_depth] <=> [rhs.job_depth, rhs.bom_depth]
    end
  end
  class << self
    def depth_reports
      @depth_reports ||= {}
    end
    def depth(job_depth, bom_depth)
      depth_reports[[job_depth, bom_depth]] ||= DepthReport.new(job_depth, bom_depth)
    end
    def to_s
      depth_reports.values.sort.map(&:to_s).join("\n")
    end
    def to_s_short
      Production::InventoryStats::DepthReport::COUNTS.map do |key|
        "#{key.to_s.titleize} = " + depth_reports.values.sum { |r| r.send(key) }.to_s
      end.join("\n")
    end
  end
end