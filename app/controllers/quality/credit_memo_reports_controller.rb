class Quality::CreditMemoReportsController < ApplicationController
  filter_access_to_defaults

  class Search
    attr_accessor :year
    def initialize(params)
      params ||= {}
      @year = params['year']
    end
    def to_date
      Date.new(self.year.to_i, 1, 1)
    end
  end

  def new
    @search = Search.new(params[:search])
    @search.year ||= Date.current.year.to_s

    @report = Quality::CreditMemoReport.new(:start_date => @search.to_date)
    @report.run
  end

  protected
  
    helper_method :year_options
    def year_options
      Date.current.year.downto(CompanyConfig.epoch_year || 2000).map(&:to_s)
    end
  
    def model_class
      Quality::CreditMemoReport
    end

end
