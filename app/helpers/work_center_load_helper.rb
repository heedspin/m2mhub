module WorkCenterLoadHelper
  def work_center_load_class(load_percentage, default='')
    # TODO: make this company specific
    if load_percentage >= 80
      'highworkload'
    else
      default.to_s
    end
  end
end