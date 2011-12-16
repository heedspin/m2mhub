class RmaReportsController < ApplicationController
  filter_access_to_defaults

  def new
    @report = RmaReport.new
    @report.run
  end

end
