module SalesBacklogHelper
  def sbl_shippable(release, prefix)
    prefix + if release.can_be_fully_shipped?
      '_full'
    elsif release.can_be_partially_shipped?
      '_part'
    else
      ''
    end
  end
end
