class CustomerOtdReportsController < ApplicationController
  filter_access_to_defaults

  def new
    @report = CustomerOtdReport.new
    @report.run
  end

end
