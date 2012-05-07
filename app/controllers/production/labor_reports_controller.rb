class Production::LaborReportsController < ApplicationController
  filter_access_to_defaults

  def index
    @report = Production::LaborReport.new(params[:labor_report])
    @report.start_date ||= Date.current.beginning_of_week
    @report.end_date ||= Date.current.end_of_week
    @report.run
    @previous_week_url = labor_reports_url(:labor_report => {:start_date => @report.start_date.advance(:weeks => -1),
                                                             :end_date => @report.end_date.advance(:weeks => -1),
                                                             :department_id => @report.department_id})
    @next_week_url = labor_reports_url(:labor_report => {:start_date => @report.start_date.advance(:weeks => 1),
                                                         :end_date => @report.end_date.advance(:weeks => 1),
                                                         :department_id => @report.department_id})
  end

  protected

    def model_class
      Production::LaborReport
    end

end
