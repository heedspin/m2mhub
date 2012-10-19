class Sales::SalesReportsController < M2mhubController
  filter_access_to_defaults :context => :sales_reports

  def index
    @sales_reports = Sales::SalesReport.by_date_desc.paginate(:page => params[:page], :per_page => 30)
    bookings_reports = Sales::BookingsReport.dates(@sales_reports.last.date, @sales_reports.first.date.advance(:days => 1))
    @date_reports = Sales::DateReport.create(:sales_reports => @sales_reports,
                                             :bookings_reports => bookings_reports).reverse
  end

  def show
    @sales_report = current_object
  end

  protected

    def model_name
      :sales_report
    end

    def model_class
      Sales::SalesReport
    end

    def current_object
      @current_object ||= Sales::SalesReport.find(params[:id])
    end
end
