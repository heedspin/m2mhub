class Production::LaborReport
  class EmployeeReport
    attr_accessor :employee
    attr_accessor :labor_details
    attr_accessor :start_time, :end_time
    def initialize(employee)
      @employee = employee
      @labor_details = []
      @start_time = nil
      @end_time = nil
    end
    def add_labor_detail(labor_detail)
      @labor_details.push(labor_detail)
      if self.start_time.nil? or (labor_detail.start_time < self.start_time)
        self.start_time = labor_detail.start_time
      end
      if self.end_time.nil? or (labor_detail.end_time > self.end_time)
        self.end_time = labor_detail.end_time
      end
    end
    def total_time
      Time.at(self.end_time - self.start_time).gmtime
    end
    def minutes_after_hour
      @minutes_after_hour ||= (self.start_time - self.start_time.change(:min => 0, :sec => 0, :usec => 0)) / 60
    end
    def late?
      (self.minutes_after_hour > CompanyConfig.labor_minutes_grace) && (self.minutes_after_hour < 30)
    end
    def employee_name
      self.employee.try(:name) || self.labor_details.first.employee_number
    end
  end

  class DateReport
    attr_accessor :date
    attr_accessor :labor_details
    def initialize(date)
      @date = date
      @labor_details = []
      @employees = {}
    end
    def add_labor_detail(labor_detail)
      (@employees[labor_detail.employee_number] ||= EmployeeReport.new(labor_detail.employee)).add_labor_detail(labor_detail)
    end
    def employee_reports
      @employees.values.sort_by { |er| er.employee_name }
    end
  end

  attr_accessor :start_date
  attr_accessor :end_date
  attr_accessor :department, :department_id
  attr_accessor :day_reports  
  
  def initialize(params)
    params ||= {}
    @start_date = (txt = params[:start_date]) && (Date.parse(txt))
    @end_date = (txt = params[:end_date]) && (Date.parse(txt))
    @department_id = params[:department_id]
    @days = {}
  end
  
  def run
    s = M2m::LaborDetail.between(@start_date, @end_date).by_date.scoped(:include => :employee)
    s = s.department(@department_id) if @department_id.present?
    s.each do |labor_detail|
      next unless labor_detail.employee.present?
      (@days[labor_detail.date] ||= DateReport.new(labor_detail.date)).add_labor_detail(labor_detail)
    end
  end
  
  def date_reports
    @days.values.sort_by(&:date)
  end
end