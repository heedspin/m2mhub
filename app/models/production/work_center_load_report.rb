class Production::WorkCenterLoadReport
  class Reporter
    def initialize
      @work_center_loads = []
    end
    def add_work_center_load(wcl)
      @work_center_loads.push wcl
    end
    def total_load_percentage
      total_load = @work_center_loads.sum(&:work_load)
      total_capacity = @work_center_loads.sum(&:capacity)
      return 0 if (total_load <= 0) or total_capacity <= 0
      (total_load.to_f / total_capacity) * 100
    end
  end
  
  class DayReport < Reporter
    attr_accessor :date
    def initialize(date)
      @date = date
      super()
    end
  end
  
  class WorkCenterReport < Reporter
    attr_accessor :work_center
    def initialize(work_center)
      @work_center = work_center
      super()
    end
    
    def work_center_load_for(day)
      @work_center_loads.detect { |wcl| wcl.date == day }
    end
    
    def avg_capacity
      @work_center_loads.sum(&:capacity).to_f / @work_center_loads.size
    end
  end
  
  attr_accessor :batch_name
  
  def initialize(params)
    params ||= {}
    @batch_name = params[:batch_name] || '**default**'
    @day_reports = {}
    @work_center_reports = {}
  end
  
  def run
    M2m::WorkCenterLoad.for_batch(@batch_name).with_load.each do |wcl|
      day_report_for(wcl.date).add_work_center_load(wcl)
      work_center_report_for(wcl.work_center).add_work_center_load(wcl)
    end
  end
  
  def ordered_day_reports
    @ordered_day_reports ||= @day_reports.values.sort_by { |d| d.date }
  end
  def ordered_work_center_reports
    @ordered_work_center_reports ||= @work_center_reports.values.sort_by { |wcr| wcr.work_center.work_center_id }
  end
  
  def day_report_for(date)
    @day_reports[date] ||= DayReport.new(date)
  end
  def work_center_report_for(wc)
    @work_center_reports[wc.work_center_id] ||= WorkCenterReport.new(wc)
  end
end