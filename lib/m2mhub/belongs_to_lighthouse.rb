require 'plutolib/with_retries'

module BelongsToLighthouse
  module ClassMethods
    def belongs_to_lighthouse_ticket
      self.class_eval <<-RUBY
      attr_accessor :lighthouse_ticket
      def lighthouse_ticket
        if @lighthouse_ticket.nil? and self.lighthouse_ticket_id and self.lighthouse_project_id
          begin
            Plutolib::WithRetries.with_retries do
              if @lighthouse_ticket = Lighthouse::Ticket.find(self.lighthouse_ticket_id, :params => { :project_id => self.lighthouse_project_id })
                # No longer necessary!
                # Convert to time objects.
                # @lighthouse_ticket.created_at = Time.parse(@ticket.created_at)
                # @lighthouse_ticket.versions.each do |v|
                #   v.created_at = Time.parse(v.created_at)
                # end
              end
            end
          rescue ActiveResource::ResourceNotFound
            # Bad link...
          end
        end
        @lighthouse_ticket
      end
      RUBY
    end
    def belongs_to_lighthouse_project
      self.class_eval <<-RUBY
      attr_accessor :lighthouse_project
      def lighthouse_project
        if @lighthouse_project.nil? and self.lighthouse_project_id
          Plutolib::WithRetries.with_retries do
            @lighthouse_project = Lighthouse::Project.find(self.lighthouse_project_id)
          end
        end
        @lighthouse_project
      end
      RUBY
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
end
