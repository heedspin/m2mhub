class Production::LaborReport
  attr_accessor :start_date
  attr_accessor :end_date
  attr_accessor :department_id
  attr_accessor :day_reports
  
  class EmployeeReport
    attr_accessor :employee_number
    attr_accessor :labor_details
    def initialize(employee_number)
      @employee_number = employee_number
      @labor_details = []
    end
    def add_labor_detail(labor_detail)
      @labor_details.push(labor_detail)
    end
  end

  class DayReport
    attr_accessor :date
    attr_accessor :labor_details
    attr_accessor :employee_reports
    def initialize(date)
      @date = date
      @labor_details = []
      @employee_reports = {}
    end
    def add_labor_detail(labor_detail)
      (@employee_reports[labor_detail.employee_number] ||= EmployeeReport.new(labor_detail.employee_number)).add_labor_detail(labor_detail)
    end
  end
  
  def initialize(params)
    @start_date = params[:start_date] || (raise ':start_date required')
    @end_date = params[:end_date] || (raise ':end_date required')
    @department = params[:department] || (raise ':department required')
    @day_reports = {}
  end
  
  def run
    M2m::LaborDetail.between(@start_date, @end_date).department(@department).by_date.each do |labor_detail|
      (@day_reports[labor_detail.date] ||= DayReport.new(labor_detail.date)).add_labor_detail(labor_detail)
    end
  end
end