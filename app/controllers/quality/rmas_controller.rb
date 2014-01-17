class Quality::RmasController < M2mhubController
  def show
    @rma = current_object
    if AppConfig.lighthouse_account
      rma_item = @rma.items.first
      title = Date.current.strftime("%y%m%d") + "-#{@rma.rma_number} -- " + @rma.customer_name.strip + ': ' + rma_item.try(:part_number)
      title[0] = 'R'
      body = rma_item.try(:reason)
      @new_inspection_task_url = new_inspection_task_url(
        :quality_inspection_task => { :task_type_id => Quality::InspectionTaskType.rma_inspection.id,
                                      :part_number => rma_item.try(:part_number),
                                      :rma_number => @rma.rma_number,
                                      :quantity => rma_item.try(:quantity),
                                      :title => title,
                                      :body => body,
                                      :create_lighthouse_ticket => 1,
                                      :lighthouse_title => title,
                                      :lighthouse_body => body,
                                      :lighthouse_project_id => AppConfig.lighthouse_rma_project_id,
                                      :lighthouse_milestone_id => AppConfig.lighthouse_rma_milestone_id,
                                      :lighthouse_assigned_user_id => current_user.lighthouse_user_id })
    end
  end

  protected

    def model_class
      M2m::Rma
    end

end
