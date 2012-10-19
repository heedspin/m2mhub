class Sales::OpportunityFromTicket
  def self.create_opportunity(ticket)
    puts "Found #{ticket.id}"
    opportunity = Sales::Opportunity.create!( :title => ticket.title,
                                              :body => ticket.body,
                                              :status_id => Sales::OpportunityStatus.active.id,
                                              :start_date => ticket.created_at )
    opportunity.comments.create!( :comment_type_id => Sales::OpportunityCommentType.comment.id,
                                  :status_id => Sales::OpportunityStatus.active.id,
                                  :comment => ticket.url )
  end
end
