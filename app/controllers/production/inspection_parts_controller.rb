class Production::InspectionItemsController < M2mhubController
  filter_access_to_defaults

  def index
    @inspection_items = model_class.all.sort_by { |ip| ip.last_inbound_transaction.time }.reverse
  end
  
  protected

    def model_class
      Production::InspectionItem
    end

end
