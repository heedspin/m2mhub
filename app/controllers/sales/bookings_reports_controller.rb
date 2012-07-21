class Sales::BookingsReportsController < M2mhubController
  filter_access_to_defaults :context => :bookings_reports

  def show
    @bookings_report = current_object
  end
  
  protected
  
    def model_class
      Sales::BookingsReport
    end
end
